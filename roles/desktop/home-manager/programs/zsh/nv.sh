#!/usr/bin/env bash
function nv() { fg %nvim 2>/dev/null || nvim "$@"; }
