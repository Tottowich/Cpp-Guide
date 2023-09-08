#!/bin/bash

# Navigate to the directory where the HelloWorld executable is located
cd code/starter-tasks/hello-world || { echo "Directory not found"; exit 1; }
# Run the compiled HelloWorld program and capture its output
output=$(./HelloWorld)

# Define the expected output
expected_output="Hello, World!"

# Check if the output matches the expected output
if [ "$output" == "$expected_output" ]; then
    exit 0
else
    echo "Expected: $expected_output"
    echo "Got: $output"
    exit 1
fi
