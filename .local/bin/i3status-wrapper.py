#!/usr/bin/env python3
import sys
import json
import os
import time

def get_keyboard_layout():
    """Simple and fast keyboard layout."""
    try:
        layout = os.popen('xkb-switch -p 2>/dev/null').read().strip()
        return 'EN' if layout == 'us' else 'RU'
    except:
        return '??'

# Заголовки
sys.stdout.write(sys.stdin.readline())
sys.stdout.write(sys.stdin.readline())

while True:
    line = sys.stdin.readline()
    if not line:
        break
    
    # i3status отправляет JSON массивы с запятыми между ними
    # Первый массив без запятой, остальные с запятой
    # НО i3bar ожидает каждый массив БЕЗ запятой в начале!
    
    # Убираем начальную запяту если есть
    if line.startswith(','):
        line = line[1:]
    
    try:
        data = json.loads(line)
        data.insert(0, {
            'full_text': get_keyboard_layout(),
            'name': 'keyboard',
            'separator': True,
            'separator_block_width': 15
        })
        
        # Выводим чистый JSON, i3bar сам добавит запятые между обновлениями
        sys.stdout.write(json.dumps(data) + '\n')
        sys.stdout.flush()
        
    except json.JSONDecodeError:
        # Если не JSON, пропускаем
        continue
