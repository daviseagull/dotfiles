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
for arg in "$@"; do
  if [ "$arg" = "--with-frontend" ]; then
    START_FRONTEND=true
    break
  fi
done


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

# Configure left pane based on frontend flag
if [ "$START_FRONTEND" = true ]; then
  # Get the first pane ID (left pane) and split it vertically
  FIRST_PANE=$(tmux list-panes -t "$SESSION_NAME:servers" -F "#{pane_id}" | head -n 1)
  tmux split-window -t "$FIRST_PANE" -v -c "$PROJECT_DIR"

  # Get all pane IDs and name them
  IFS=$'\n' read -r -d '' -a PANE_IDS < <(tmux list-panes -t "$SESSION_NAME:servers" -F "#{pane_id}" && printf '\0')
  if [ ${#PANE_IDS[@]} -ge 3 ]; then
    tmux select-pane -t "${PANE_IDS[0]}" -T "backend"
    tmux select-pane -t "${PANE_IDS[1]}" -T "frontend"
    tmux select-pane -t "${PANE_IDS[2]}" -T "claude"
    
    # Send commands to panes
    tmux send-keys -t "${PANE_IDS[0]}" "pnpm start:local" Enter
    tmux send-keys -t "${PANE_IDS[1]}" "pnpm start:web" Enter
    tmux send-keys -t "${PANE_IDS[2]}" "claude" Enter
  fi
else
  # Get pane IDs for 2-pane layout
  IFS=$'\n' read -r -d '' -a PANE_IDS < <(tmux list-panes -t "$SESSION_NAME:servers" -F "#{pane_id}" && printf '\0')
  if [ ${#PANE_IDS[@]} -ge 2 ]; then
    tmux select-pane -t "${PANE_IDS[0]}" -T "backend"
    tmux select-pane -t "${PANE_IDS[1]}" -T "claude"
    
    # Send commands to panes
    tmux send-keys -t "${PANE_IDS[0]}" "pnpm start:local" Enter
    tmux send-keys -t "${PANE_IDS[1]}" "claude" Enter
  fi
fi

# Set focus to the editor window
tmux select-window -t "$SESSION_NAME:editor"

echo "Session '$SESSION_NAME' created successfully!"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
