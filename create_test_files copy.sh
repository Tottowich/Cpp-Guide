#!/bin/bash

# Function to format labels by replacing spaces with dashes and converting to lowercase
format_label() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
}

# Function to create test script if it doesn't exist
create_test_script() {
    local task_name="$1"
    local level="$2"
    
    # Create the test script path
    local test_script_path="tests/$level/$task_name"
    local test_script_file="$test_script_path/test_$task_name.sh"
    
    # Create the directories if they don't exist

    mkdir -p "$test_script_path"
    
    # Check if the test script file already exists
    if [ ! -f "$test_script_file" ]; then
        # echo "Creating test script for $task_name ($level)..."
        
        # Create the test script
        # echo 
        echo "#!/bin/bash" > "$test_script_file"
        echo "echo 'In-complete test script for $task_name ($level)'" >> "$test_script_file"
        echo "exit 3" >> "$test_script_file"
        # Make the script executable
        chmod +x "$test_script_file"
    else
        echo "Test script for $task_name ($level) already exists."
        echo "exit 3" >> "$test_script_file"
    fi
}

# Read the README.md file to get the list of tasks and their levels
while read -r line; do
    if [[ "$line" == "### "* ]]; then
        level=$(echo "$line" | sed 's/^### //; s/ 🍼//; s/ 🌱//; s/ ⚙️//; s/ 🔥//')
        formatted_level=$(format_label "$level")
    elif [[ "$line" == "- [ ] "* ]]; then
        task_name=$(echo "$line" | sed 's/^- \[ \] //')
        formatted_task_name=$(format_label "$task_name")
        
        # Create the test script for each task if it doesn't exist
        create_test_script "$formatted_task_name" "$formatted_level"
    fi
done < <(awk '/## Completed Tasks ✅/,0' README.md)
