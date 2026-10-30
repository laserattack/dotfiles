tmux3() {
  tmux new-session -d -s main -n launcher
  tmux new-window -t main -n home
  tmux new-window -t main -n work
  tmux select-window -t main:launcher
  tmux attach -t main
}
