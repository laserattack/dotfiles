#!/bin/sh
# Обертка для i3status с добавлением текущей раскладки

i3status | while :
do
        # Читаем строку из i3status
        read line

        # Получаем текущую раскладку
        LAYOUT=$(xkb-switch)

        # Выводим модифицированную строку
        echo "layout: $LAYOUT | $line" || exit 1
done
