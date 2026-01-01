#!/usr/bin/env bash

# Debug log
exec > /tmp/yazi-picker-debug.log 2>&1
set -x

tmpfile=$(mktemp)

# Get the directory from the buffer name, fallback to current dir if invalid
start_dir="$2"
if [[ -f "$start_dir" ]]; then
	start_dir=$(dirname "$start_dir")
elif [[ ! -d "$start_dir" ]]; then
	start_dir="."
fi

echo "Start dir: $start_dir"

yazi "$start_dir" --chooser-file="$tmpfile"
echo "Yazi exit code: $?"

echo "Tmpfile contents:"
cat "$tmpfile"
echo ""

# Read paths, handling files without trailing newline
paths=""
while IFS= read -r line || [[ -n "$line" ]]; do
	paths+=$(printf "%q " "$line")
done < "$tmpfile"
echo "Paths: $paths"

rm -f "$tmpfile"

if [[ -n "$paths" ]]; then
	zellij action toggle-floating-panes
	zellij action write 27 # send <Escape> key
	zellij action write-chars ":$1 $paths"
	zellij action write 13 # send <Enter> key
else
	zellij action toggle-floating-panes
fi
