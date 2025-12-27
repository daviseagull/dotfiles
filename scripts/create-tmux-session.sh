#!/bin/bash
#!/bin/zsh
#!/bin/sh:qa

# Check if session name is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <session_name> [--frontend] [--backend]"
  echo "Example: $0 myproject"
  echo "Example: $0 myproject --frontend"
  echo "Example: $0 myproject --backend"
  echo "Example: $0 myproject --frontend --backend"
  exit 1
fi

# Configuration
SESSION_NAME="$1"
PROJECT_DIR="$(pwd)" # Always uses current directory
START_FRONTEND=false
START_BACKEND=false

# Check for flags
for arg in "$@"; do
  if [ "$arg" = "--frontend" ]; then
    START_FRONTEND=true
  elif [ "$arg" = "--backend" ]; then
    START_BACKEND=true
  fi
done


# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session '$SESSION_NAME' already exists. Attaching..."
  tmux attach-session -t "$SESSION_NAME"
  exit 0
fi

echo "Creating new tmux session: $SESSION_NAME"

# Window 1: Editor
tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n "editor"
tmux send-keys -t "$SESSION_NAME:editor" "nvim" Enter

# Window 2: Terminal (with claude on left 75%, blank terminal on right 25%)
tmux new-window -t "$SESSION_NAME" -n "terminal" -c "$PROJECT_DIR"
tmux send-keys -t "$SESSION_NAME:terminal" "claude" Enter
tmux split-window -t "$SESSION_NAME:terminal" -h -p 30 -c "$PROJECT_DIR"

# Window 3: Servers (conditional based on flags)
if [ "$START_FRONTEND" = true ] || [ "$START_BACKEND" = true ]; then
  tmux new-window -t "$SESSION_NAME" -n "servers" -c "$PROJECT_DIR"

  if [ "$START_FRONTEND" = true ] && [ "$START_BACKEND" = true ]; then
    # Both flags: split window and run both commands
    tmux split-window -t "$SESSION_NAME:servers" -h -c "$PROJECT_DIR"

    # Get pane IDs
    IFS=$'\n' read -r -d '' -a PANE_IDS < <(tmux list-panes -t "$SESSION_NAME:servers" -F "#{pane_id}" && printf '\0')
    if [ ${#PANE_IDS[@]} -ge 2 ]; then
      tmux select-pane -t "${PANE_IDS[0]}" -T "frontend"
      tmux select-pane -t "${PANE_IDS[1]}" -T "backend"

      # Send commands to panes
      tmux send-keys -t "${PANE_IDS[0]}" "pnpm start:web" Enter
      tmux send-keys -t "${PANE_IDS[1]}" "pnpm start:local" Enter
    fi
  elif [ "$START_FRONTEND" = true ]; then
    # Only frontend: single pane
    tmux select-pane -t "$SESSION_NAME:servers" -T "frontend"
    tmux send-keys -t "$SESSION_NAME:servers" "pnpm start:web" Enter
  elif [ "$START_BACKEND" = true ]; then
    # Only backend: single pane
    tmux select-pane -t "$SESSION_NAME:servers" -T "backend"
    tmux send-keys -t "$SESSION_NAME:servers" "pnpm start:local" Enter
  fi
fi

# Set focus to the editor window
tmux select-window -t "$SESSION_NAME:editor"

echo "Session '$SESSION_NAME' created successfully!"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
