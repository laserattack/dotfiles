#!/bin/sh

i3status | while :
do
        read line
        LAYOUT=$(xkb-switch)
        echo "|$line|layout: $LAYOUT" || exit 1
done
