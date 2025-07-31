#!/bin/bash

# Check if session name is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <session_name> [--with-frontend]"
  echo "Example: $0 myproject"
  echo "Example: $0 myproject --with-frontend"
  exit 1
fi

# Configuration
SESSION_NAME="$1"
PROJECT_DIR="$(pwd)" # Always uses current directory
START_FRONTEND=false

# Check for frontend flag
if [ "$2" = "--with-frontend" ]; then
  START_FRONTEND=true
fi

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session '$SESSION_NAME' already exists. Attaching..."
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

echo "Creating new tmux session: $SESSION_NAME"

# Create new tmux session (detached) and rename the first window
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n "editor"

# Start Neovim in the editor window
tmux send-keys -t "$SESSION_NAME:editor" "nvim" Enter

# Window 2: Development servers (with 2 panes)
tmux new-window -t "$SESSION_NAME" -n "servers" -c "$PROJECT_DIR"

# Split the servers window horizontally (creates 2 panes)
tmux split-window -t "$SESSION_NAME:servers" -h -c "$PROJECT_DIR"

# Send command to the left pane (pane 0)
tmux send-keys -t "$SESSION_NAME:servers.left" "pnpm start:local" Enter

# Send command to the right pane (pane 1)
if [ "$START_FRONTEND" = true ]; then
  tmux send-keys -t "$SESSION_NAME:servers.right" "pnpm start:web" Enter

  tmux select-pane -t "$SESSION_NAME:servers.right"

  tmux split-window -v
fi

# Set focus to the editor window
tmux select-window -t "$SESSION_NAME:editor"

echo "Session '$SESSION_NAME' created successfully!"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
