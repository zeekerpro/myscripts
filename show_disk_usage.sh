#!/bin/bash

# Function to collect and display directories and files larger than 200MB
function show_tree {
    local path=$1
    local max_depth=$2
    local current_depth=$3
    local prefix=$4

    # Get the size of the current directory
    local size=$(du -sh "$path" 2>/dev/null | cut -f1)
    local size_in_mb=$(du -sm "$path" 2>/dev/null | cut -f1)

    # Check if size is greater than or equal to 200MB
    if [ "$size_in_mb" -ge 200 ]; then
        # Print the size and path of the current directory
        echo "${prefix}${path##*/} ($size)"

        # Traverse subdirectories
        if [ "$current_depth" -lt "$max_depth" ]; then
            local items=()
            for subdir in "$path"/*; do
                if [ -d "$subdir" ] || [ -f "$subdir" ]; then
                    local sub_size=$(du -sm "$subdir" 2>/dev/null | cut -f1)
                    items+=("$sub_size $subdir")
                fi
            done

            # Sort items by size in descending order
            IFS=$'\n' sorted=($(sort -rn <<<"${items[*]}"))
            unset IFS

            for item in "${sorted[@]}"; do
                local subdir=$(echo $item | cut -d' ' -f2-)
                local sub_size=$(echo $item | cut -d' ' -f1)
                if [ -d "$subdir" ]; then
                    show_tree "$subdir" "$max_depth" $(($current_depth + 1)) "$prefix  ├── "
                elif [ -f "$subdir" ]; then
                    if [ "$sub_size" -ge 200 ]; then
                        local file_size=$(du -sh "$subdir" 2>/dev/null | cut -f1)
                        echo "${prefix}  ├── ${subdir##*/} ($file_size)"
                    fi
                fi
            done
        fi
    fi
}

# Display from root directory with a maximum depth of 6
show_tree "/" 6 0 ""
