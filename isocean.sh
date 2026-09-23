#!/bin/sh
unzip -ql "$@" | grep -qs 'oceanofpdf' && echo "$@"
