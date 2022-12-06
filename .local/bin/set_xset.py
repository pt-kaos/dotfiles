#!/usr/bin/python

import subprocess, shlex


text = subprocess.run(shlex.split('xset q'), capture_output=True, text=True)
if "DPMS is Disabled" in text.stdout:
    subprocess.run(shlex.split('xset +dpms'), capture_output=False, text=False)
    subprocess.run(shlex.split('xset s on'), capture_output=False, text=False)
    subprocess.run(shlex.split('dm_message -n "Screen Saver Timeout Active"'), capture_output=False, text=False)
if "DPMS is Enabled" in text.stdout:
    subprocess.run(shlex.split('xset -dpms'), capture_output=False, text=False)
    subprocess.run(shlex.split('xset s off'), capture_output=False, text=False)
    subprocess.run(shlex.split('dm_message -a "Screen Saver Timeout Inactive"'), capture_output=False, text=False)

