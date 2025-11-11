#!/bin/sh

i3status | while :
do
        # Читаем строку из i3status
        read line

        # Получаем текущую раскладку
        LAYOUT=$($HOME/.local/bin/xkb-switch)

        # Выводим модифицированную строку
        echo "layout: $LAYOUT | $line" || exit 1
done
