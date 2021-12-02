#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch top bar
echo "---" | tee -a /tmp/polybar-top.log
polybar top 2>&1 | tee -a /tmp/polybar-top.log & disown

echo "Polybar launched (top) ..."
