#!/bin/bash

# this simulates an application that primarily prints to stdout,
# but also has background logs we would want to follow like nginx
# access.log or elastic-gc.log

seq 1 10 \
	| xargs -n 1 bash -c 'sleep 1; echo "$0" | tee -a /post-sleep.log' \
	| tee -a '/pre-doubling.log' \
	| awk '{print($1 " " $1)}' \
	| tee -a '/doubling.log' \
	| awk '{print($1)}' \
	| cat -n
