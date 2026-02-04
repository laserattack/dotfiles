#!/usr/bin/env python3
import sys, json, subprocess, datetime

def get_layout():
    try:
        result = subprocess.run(['xkb-switch', '-p'], 
                              capture_output=True, text=True)
        layout = result.stdout.strip() if result.returncode == 0 else 'us'
        return 'EN' if layout == 'us' else 'RU'
    except:
        return '??'

# Читаем заголовки
print(sys.stdin.readline(), end='')  # версия
print(sys.stdin.readline(), end='')  # начало массива

while True:
    line = sys.stdin.readline()
    if not line:
        break
    
    # Убираем запятую в начале если есть
    if line.startswith(','):
        line = line[1:]
        prefix = ','
    else:
        prefix = ''
    
    try:
        data = json.loads(line)
        # Добавляем нашу информацию
        data.insert(0, {
            'full_text': f'[{datetime.datetime.now().strftime("%S")} {get_layout()}]',
            'name': 'test'
        })
        print(prefix + json.dumps(data), flush=True)
    except:
        # Если не JSON, выводим как есть
        print(prefix + line, end='', flush=True)
