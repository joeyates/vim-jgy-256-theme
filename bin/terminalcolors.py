#!/usr/bin/env python
# Copyright (C) 2006 by Johannes Zellner, <johannes@zellner.org>
# modified by mac@calmar.ws to fit my output needs
# modified by crncosta@carloscosta.org to fit my output needs
# modified by joeyates, 2014

from os import system

def foreground(n):
    system('tput setaf %u' % n)

def background(n):
    system('tput setab %u' % n)

def out(n):
    background(n)
    system('echo -n "% 4d"' % n)

def table(start, end, width):
    def is_end_of_row(n):
        return (n - start + 1) % width == 0

    for n in range(start, end + 1):
        out(n)
        if is_end_of_row(n):
            print

foreground(16)

# normal colors
table(0, 15, 8)
print
# other colors
table(16, 231, 6)
print
# greyscale
table(232, 255, 6)

foreground(7)
background(0)
