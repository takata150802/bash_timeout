#!/bin/env python

import os
from time import sleep
pid = os.getpid()

print ("pid: ", pid)

i = 0
while True:
    print ('%d,' % i, end='', flush=True)
    if (i + 1) % 16 == 0:
        print ()
    i += 1
    sleep(1)
