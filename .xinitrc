#!/usr/bin/env bash

if [ -f "$HOME/.xprofile" ]; then
    . "$HOME/.xprofile"
fi

if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

exec i3
