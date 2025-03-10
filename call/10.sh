#!/bin/bash
# route -n
script_dir="$(dirname "$0")"
base_dir="$(dirname "$script_dir")"
log_dir="$base_dir/log"

mkdir -p "$log_dir"

command="route -n"
# コマンド名を安全なファイル名に変換
safe_command_name=$(echo "$command" | tr -c 'a-zA-Z0-9_-' '_')
output_file="$log_dir/output_${safe_command_name}_$(date +%Y%m%d_%H%M%S).txt"

echo "Command: $command" | tee -a "$output_file"
$command | tee -a "$output_file"
echo "Execution result saved to $output_file."