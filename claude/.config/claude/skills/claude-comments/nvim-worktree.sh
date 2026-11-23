#!/bin/sh
# Run an Ex command in every Neovim instance whose cwd is inside the current git worktree.
# nvims are found via the OS (socket name -> pid -> cwd), so nvims elsewhere are never contacted.
# Usage: nvim-worktree.sh '<ex command>'   (no single quotes in the command)
root=$(git rev-parse --show-toplevel) || exit 1
dir="${TMPDIR:-/tmp/}nvim.$USER"
pids=$(for s in "$dir"/*/nvim.*.0; do s=${s##*/nvim.}; echo "${s%.0}"; done | grep -x '[0-9]*' | paste -sd, -)
[ -n "$pids" ] || exit 0
lsof -a -d cwd -p "$pids" -Fpn 2>/dev/null | while read -r line; do
  case "$line" in
    p*) pid=${line#p} ;;
    n*) case "${line#n}/" in
          "$root"/*) for sock in "$dir"/*/nvim."$pid".0; do
                       nvim --server "$sock" --remote-expr "execute('$1')" >/dev/null && echo "$sock (${line#n})"
                     done ;;
        esac ;;
  esac
done
