#!/bin/bash

scripts=`find . -type f \( -name 'script_*.py' -o -name 'script_*.R' \) -not -path "*.venv/" | sort`

echo "$scripts" | sed 's/ /\\ /g' | xargs wc -l | tee ./misc/script_length.txt
