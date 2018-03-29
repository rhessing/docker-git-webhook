#!/bin/bash
for file in $(ls -1 /custom_scripts/before_push/); do
    "$file"
done
