#!/bin/sh

echo "=== Lofree Flow Keyboard Fn Key Fix ==="
echo
echo "Step 1: Switch keyboard to macOS/iOS mode"
echo "        Press: Fn + M"
echo
read -p "Press Enter after switching to macOS mode... " PRESSKEY
echo
echo "Step 2: Setting fnmode to 2 (enables F1-F12 as default)"
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo
echo "Done! Your F-keys should now work as function keys by default."
echo "Media keys will require pressing Fn + F-key."
echo
echo "Note: You can switch back to Windows/Android mode with Fn + N"
echo "      (but you'll lose the function key fix)"
