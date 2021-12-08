#!/bin/bash

scripts=`find ../. -type f -name 'script*.R' | sort`

echo "$scripts" | sed 's/ /\\ /g' | xargs wc -l | tee ./script_length.txt
