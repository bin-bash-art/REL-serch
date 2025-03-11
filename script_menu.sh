#!/bin/bash
# Change to the script directory
cd "$(dirname "$0")"

# Display settings
COLUMNS=4 # Number of columns to display

while true; do
    clear
    echo "Available Scripts:"
    echo "------------------------"
    
    # Get script list and store in array
    scripts=($(ls call/*.sh | grep -v "$0" | sort -V))
    total_scripts=${#scripts[@]}
    
    # Get description for each script
    # 連想配列を使用して数値インデックスの問題を回避
    declare -A descriptions
    for script in "${scripts[@]}"; do
        script_num=$(basename "$script" .sh)
        desc=$(head -n 2 "$script" | grep "^#" | tail -n 1 | sed 's/# //')
        # 文字列キーとして扱う
        descriptions["$script_num"]="$desc"
    done
    
    # Calculate maximum display width
    max_width=25  # Default width
    for script_num in "${!descriptions[@]}"; do
        if [ ${#script_num} -gt $max_width ]; then
            max_width=${#script_num}
        fi
    done
    
    # Display in multiple columns
    rows=$(( (total_scripts + COLUMNS - 1) / COLUMNS ))
    for (( i=0; i<rows; i++ )); do
        line=""
        for (( j=0; j<COLUMNS; j++ )); do
            idx=$((i + j*rows))
            if [ $idx -lt $total_scripts ]; then
                script="${scripts[$idx]}"
                script_num=$(basename "$script" .sh)
                desc="${descriptions[$script_num]}"
                # Adjust display width for alignment
                printf -v entry "%-4s: %-25s" "$script_num" "${desc:0:25}"
                line+="$entry    "
            fi
        done
        echo "$line"
    done
    
    echo ""
    echo "Enter script numbers (example: 01 02 03) or 'q' to quit:"
    read input
    
    if [ "$input" = "q" ] || [ "$input" = "Q" ]; then
        echo "Exiting program."
        break
    fi
    
    # Split input by spaces and store in array
    IFS=' ' read -r -a script_numbers <<< "$input"
    
    # Process each script number
    for number in "${script_numbers[@]}"; do
        script_name="call/${number}.sh"  # Specify call directory
        
        if [ -f "$script_name" ]; then
            echo "Executing: $script_name"
            bash "$script_name"
            echo "Execution completed: $script_name"
        else
            echo "Script does not exist: $script_name"
        fi
        echo ""
    done
    
    echo "All specified scripts have been executed."
    echo "Press Enter to continue..."
    read
done



