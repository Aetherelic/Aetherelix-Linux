#!/usr/bin/env python3
import os
import random
import shutil
import signal
import sys
import time

CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{};:,.<>/?"
running = True

def stop(*_):
    global running
    running = False

signal.signal(signal.SIGINT, stop)
signal.signal(signal.SIGTERM, stop)

def move(y, x):
    sys.stdout.write(f"\033[{y};{x}H")

def hide_cursor():
    sys.stdout.write("\033[?25l")

def show_cursor():
    sys.stdout.write("\033[?25h")

def clear():
    sys.stdout.write("\033[2J\033[H")

def colour(level):
    # soft green/white, no inverse video, no black blocks
    if level == 0:
        return "\033[38;2;230;255;230m"
    if level == 1:
        return "\033[38;2;190;230;180m"
    if level == 2:
        return "\033[38;2;140;190;135m"
    return "\033[38;2;95;130;95m"

try:
    hide_cursor()
    clear()

    cols, rows = shutil.get_terminal_size((80, 24))
    columns = max(1, cols // 2)
    drops = [random.randint(-rows, rows) for _ in range(columns)]
    speeds = [random.choice([1, 1, 1, 2]) for _ in range(columns)]
    lengths = [random.randint(8, max(10, rows // 2)) for _ in range(columns)]

    last_size = (cols, rows)

    while running:
        cols, rows = shutil.get_terminal_size((80, 24))

        if (cols, rows) != last_size:
            clear()
            columns = max(1, cols // 2)
            drops = [random.randint(-rows, rows) for _ in range(columns)]
            speeds = [random.choice([1, 1, 1, 2]) for _ in range(columns)]
            lengths = [random.randint(8, max(10, rows // 2)) for _ in range(columns)]
            last_size = (cols, rows)

        for i in range(columns):
            x = i * 2 + 1
            head = drops[i]
            length = lengths[i]

            # erase tail
            tail = head - length
            if 1 <= tail <= rows:
                move(tail, x)
                sys.stdout.write(" ")

            # draw trail
            for offset in range(min(length, 4)):
                y = head - offset
                if 1 <= y <= rows:
                    move(y, x)
                    sys.stdout.write(colour(offset) + random.choice(CHARS) + "\033[0m")

            drops[i] += speeds[i]

            if drops[i] - length > rows:
                drops[i] = random.randint(-rows, 0)
                lengths[i] = random.randint(8, max(10, rows // 2))
                speeds[i] = random.choice([1, 1, 1, 2])

        sys.stdout.flush()
        time.sleep(0.055)

finally:
    show_cursor()
    sys.stdout.write("\033[0m\n")
    sys.stdout.flush()
