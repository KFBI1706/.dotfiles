#!/usr/bin/env bash

# TODO: consider <https://i3wm.org/docs/userguide.html#no_focus>.

tmux new-session -d -s "youtube" ~/Projects/scripts/mpv.sh "$1"
