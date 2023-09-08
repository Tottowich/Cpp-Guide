#!/bin/bash

# Function to run test based on task name and level
run_test() {
    local task_name="$1"
    local level="$2"
    
    test_script="tests/$level/$task_name/test_$task_name.sh"
    if [ -f "$test_script" ]; then
        echo "Running test for $task_name ($level)..."
        # Return output of test script
        bash "$test_script"
        # Capture the exit code of the test script
        local exit_code=$?
        # Return the exit code
        return $exit_code

    else
        echo "Test script for $task_name ($level) not found."
        # Create the test script path
        local test_script_path="tests/$level/$task_name"
        # Create the test script
        echo "#!/bin/bash" > "$test_script_path/test_$task_name.sh"
        return 1
    fi
}

format_label() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
}
# Extract task list from README.md and run only the specified task
extract_and_run_task() {
    local target_task="$1"
    local task_name=""
    # List to keep track of available tasks
    local tasks=()
    local level=""
    local success=1
    while read -r line; do
        if [[ "$line" == "### "* ]]; then
            level=$(echo "$line" | sed 's/^### //; s/ 🍼//; s/ 🌱//; s/ ⚙️//; s/ 🔥//')
            tasks+=("---${level}---")
            formatted_level=$(format_label "$level")
        elif [[ "$line" == "- [ ] "* ]]; then
            task_name=$(echo "$line" | sed 's/^- \[ \] //')
            formatted_task_name=$(format_label "$task_name")
            tasks+=("$formatted_task_name")
            if [ "$formatted_task_name" == "$target_task" ]; then
                original_task_name="$task_name"
                run_test "$formatted_task_name" "$formatted_level"
                success=$?
                if [ $success -eq 0 ]; then
                    mark_task_complete "$original_task_name"
                fi
                return $success
            fi
        elif [[ "$line" == "- [x] "* ]]; then
            task_name=$(echo "$line" | sed 's/^- \[x\] //')
            formatted_task_name=$(format_label "$task_name")
            tasks+=("$formatted_task_name")
            if [ "$formatted_task_name" == "$target_task" ]; then
                original_task_name="$task_name"
                run_test "$formatted_task_name" "$formatted_level"
                success=$?
                if [ $success -eq 1 ]; then
                    mark_task_incomplete "$original_task_name"
                fi
                return $success
            fi
        fi
    done < <(awk '/## Completed Tasks ✅/,0' README.md)
    # Did not find the task in the list of completed tasks
    echo "Task not found. Available tasks:"
    for task in "${tasks[@]}"; do
        echo "- $task"
    done
    return 2
}

mark_task_complete() {
    local target_task="$1"
    # Use awk to find and replace the line in README.md
    awk -v task="$target_task" '
    {
        if ($0 ~ "- \\[ \\] " task "$") {
            gsub("- \\[ \\] ", "- [x] ", $0);
        }
        print $0;
    }
    ' README.md > README.tmp && mv README.tmp README.md
    echo "Marked $target_task as complete."
}
mark_task_incomplete() {
    local target_task="$1"
    # Use awk to find and replace the line in README.md
    awk -v task="$target_task" '
    {
        if ($0 ~ "- \\[x\\] " task "$") {
            gsub("- \\[x\\] ", "- [ ] ", $0);
        }
        print $0;
    }
    ' README.md > README.tmp && mv README.tmp README.md
    echo "Marked $target_task as incomplete."
}

# Check for task name argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [Task-Name]"
    exit 1
fi

task_name="$*"
formatted_task_name=$(format_label "$task_name")

# Run the test for the specified task
extract_and_run_task $formatted_task_name

# Capture the exit code of the test script
exit_code=$?
# Check the exit code to determine if the test passed or failed
if [ $exit_code -eq 0 ]; then
    echo "$task_name: Test Passed! 🎉"
elif [ $exit_code -eq 1 ]; then
    echo "$task_name: Test Failed! 😞"
elif [ $exit_code -eq 2 ]; then
    echo "$task_name: Task not found. 😞"
elif [ $exit_code -eq 3 ]; then
    echo "$task_name: Test script not complete. 🤔"
else
    echo "$task_name: Unknown error. 😞"
fi
