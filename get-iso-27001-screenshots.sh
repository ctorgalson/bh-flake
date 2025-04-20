#!/usr/bin/env bash

active_window=$(gnome-control-center privacy &)
echo "$active_window"
# xdotool windowclose "$active_window"
