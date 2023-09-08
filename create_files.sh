#!/bin/bash

# Function to format labels by replacing spaces with dashes and converting to lowercase
format_label() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
}

# Function to create test script and markdown file if they don't exist
create_test_script_and_markdown() {
    local task_name="$1"
    local level="$2"
    
    # Create the test script path
    local test_script_path="tests/$level/$task_name"
    local test_script_file="$test_script_path/test_$task_name.sh"
    local markdown_path="tasks/$level/$task_name"
    local markdown_file="$markdown_path/$task_name.md"
    
    # Create the directories if they don't exist
    mkdir -p "$test_script_path"
    
    # Check if the test script file already exists
    if [ ! -f "$test_script_file" ]; then
        # Create the test script
        echo "#!/bin/bash" > "$test_script_file"
        echo "echo 'In-complete test script for $task_name ($level)'" >> "$test_script_file"
        echo "exit 3" >> "$test_script_file"
        # Make the script executable
        chmod +x "$test_script_file"
    else
        echo "Test script for $task_name ($level) already exists."
    fi
    mkdir -p "$markdown_path"
    # Check if the markdown file already exists
    if [ ! -f "$markdown_file" ]; then
        # Create the markdown file
        echo "# $task_name" > "$markdown_file"
        echo "## Level: $level" >> "$markdown_file"
        echo "## Description" >> "$markdown_file"
        echo "This is an incomplete description for $task_name." >> "$markdown_file"
    else
        echo "Markdown file for $task_name ($level) already exists."
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
        
        # Create the test script and markdown file for each task if they don't exist
        create_test_script_and_markdown "$formatted_task_name" "$formatted_level"
    fi
done < <(awk '/## Completed Tasks ✅/,0' README.md)
