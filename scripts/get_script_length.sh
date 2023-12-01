#!/bin/bash

scripts=`find . -type f \( -name 'script_*.R' -o -name 'script_*.py' \) -not -path "*.venv/" | sort`

echo "$scripts" | sed 's/ /\\ /g' | xargs wc -l | tee ./misc/script_length.txt
