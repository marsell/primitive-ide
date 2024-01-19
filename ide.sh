#!/bin/bash
#
# Dependencies: tmux, neovim, ctags, fzf.
# Suggest using fish as the shell for more autocompletion.

CLIPBOARD="/mnt/c/Windows/system32/clip.exe"
EDITOR="nvim"

pushd ${1:-.}
tmux new-session "fzf --exact --preview-window=up --preview='head -40 {}' --scheme=path --bind='ctrl-c:ignore,ctrl-d:ignore,esc:ignore,enter:execute(tmux split-window -l60% -bvt1 '\'''$EDITOR' {}'\'')'" \; \
     split-window -h -l70% "ctags -R --languages=C,C++,Elixir,Erlang,Go,JavaScript,Lisp,Make,Python,Ruby,Rust,Sh,Yaml --exclude='*/node_modules/*/node_modules/*'; exec $SHELL" \; \
     set-option status off \; \
     set-option mouse on \; \
     bind-key -T copy-mode MouseDragEnd1Pane send -X copy-pipe-and-cancel "$CLIPBOARD"
popd
