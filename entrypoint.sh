#!/bin/sh

# Startup Xvfb so an actually headless machine can pretend to have a display
Xvfb -ac :99 -screen 0 1280x1024x16 > /dev/null 2>&1 &

# Export some variables
export DISPLAY=:99.0
export PUPPETEER_EXEC_PATH="chromium"

# Run commands
cmd=$@
echo "Running '$cmd'!"
if $cmd; then
    echo "Successfully ran '$cmd'"
else
    exit_code=$?
    echo "Failure running '$cmd', exited with $exit_code"
    exit $exit_code
fi
