#!/bin/bash
for file in $(ls -1 /custom_scripts/after_push/); do
    "$file"
done
