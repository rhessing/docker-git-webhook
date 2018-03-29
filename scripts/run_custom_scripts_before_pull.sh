#!/bin/bash
for file in $(ls -1 /custom_scripts/before_pull/); do
    "$file"
done
