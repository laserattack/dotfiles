#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import json
import subprocess

def get_keyboard_layout():
    """Get current keyboard layout."""
    try:
         result = subprocess.run(['xkb-switch', '-p'], 
                              capture_output=True, text=True)
         layout = result.stdout.strip()
    except:
        layout = 'jopa'
    
    return f'{layout}'

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert keyboard layout at the start
        j.insert(0, {
            'full_text': get_keyboard_layout(),
            'name': 'keyboard',
            'separator': True,
            'separator_block_width': 20
        })
        # and echo back new encoded json
        print_line(prefix + json.dumps(j))
