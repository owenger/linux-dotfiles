#!/bin/bash

internal_monitor="eDP1"
monitor_1="DP-1-1"
home_monitor_2="DP-1-2"
work_monitor_2="DP-1-3"

xrandr --output "$internal_monitor" --on

if xrandr | grep -q "$work_monitor_2 connected"; then
    xrandr --output "$internal_monitor" --off
    xrandr --output "$monitor_1" --auto --primary
    xrandr --output "$work_monitor_2" --auto --right-of "$monitor_1"
fi

if xrandr | grep -q "$monitor_1 connected"; then
    xrandr --output "$internal_monitor" --off
    xrandr --output "$monitor_1" --auto --primary
    xrandr --output "$home_monitor_2" --auto --right-of "$monitor_1"
fi
