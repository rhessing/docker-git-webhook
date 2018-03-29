#!/bin/bash
for file in $(ls -1 /custom_scripts/on_startup/); do
    "$file"
done
