#!/bin/bash
for f in $@; do cp "$f" "${f/\.*/_1\.${f##*.}}"; done

#            (can change _1 to date-time etc)
