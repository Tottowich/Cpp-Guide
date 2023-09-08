#!/bin/bash

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

while read -r line; do
    if [[ "$line" == "### "* ]]; then
        level=$(echo "$line" | sed 's/^### //; s/ 🍼//; s/ 🌱//; s/ ⚙️//; s/ 🔥//')
    elif [[ "$line" == "- [x] "* ]]; then
        task_name=$(echo "$line" | sed 's/^- \[x\] //')
        mark_task_incomplete "$task_name"

    fi
done < <(awk '/## Completed Tasks ✅/,0' README.md)

