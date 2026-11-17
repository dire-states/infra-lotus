#!/usr/bin/env bash
# Load every tmuxp session in this folder, detached. Running sessions are skipped.
set -euo pipefail

cd "$(dirname "$0")"

for f in *.yaml; do
    name=$(sed -n 's/^session_name: *//p' "$f")
    if tmux has-session -t "=$name" 2>/dev/null; then
        echo "skip  $name (already running)"
    else
        tmuxp load -d "$f"
        echo "load  $name"
    fi
done

tmux ls
