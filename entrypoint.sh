#!/bin/bash

# this file acts as the container's "wrapper" I guess?
# The goal is to make a single stream of labeled log entries that are a combination of the main application and the log files

# good
# 	files were labeled right
# bad
#   missing
#     run.sh stdout
#   no timestamps at all
function try-56(){
	multitail -w -ts -D -n 0 --mergeall -cT ANSI --label 'waffle-app ' -l '/run.sh' --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}


# good
# 	timestamps showed up for doubling.log
# bad
#   doubling.log labeled "waffle-app"...
#   missing
#     run.sh stdout
#   no timestamps
#     post-sleep.log
#     pre-doubling.log
function try-57(){
	/run.sh | multitail -w -ts -D -n 0 --mergeall -cT ANSI --label 'waffle-app ' -j --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}


# good
# 	timestamps showed up for doubling.log
# bad
#   missing
#     run.sh stdout
#   no label
#     doubling.log
#   no timestamps
#     post-sleep.log
#     pre-doubling.log
function try-58(){
	/run.sh | multitail -w -ts -D -n 0 --mergeall -cT ANSI -j --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}

# no change from try-58
function try-59(){
	/run.sh 2>&1 | multitail -w -ts -D -n 0 --mergeall -cT ANSI -j --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}

# no change from try-59
function try-60(){
	/run.sh | multitail -w -ts -D -n 0 --mergeall -j --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}

# good
# 	post-sleep.log 100% correct
# bad
#   missing
#     run.sh stdout
#     doubling.log
#   no timestamps
#     pre-doubling.log
function try-61(){
	/run.sh | multitail -j -w -ts -D -n 0 --mergeall --retry-all -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -cT ANSI --label 'doubling.log - ' /doubling.log
}


# good
# 	post-sleep.log 100% correct
#   pre-doubling.log 100% correct
# bad
#   missing
#     run.sh stdout
#   no labels
#     doubling.log
#   no timestamps
#     doubling.log
function try-62(){
	/run.sh | multitail -j --mergeall --retry-all -w -D -n 0  -ts -cT ANSI --label 'post-sleep.log - ' /post-sleep.log -ts -cT ANSI --label 'pre-doubling.log - ' /pre-doubling.log -ts -cT ANSI --label 'doubling.log - ' /doubling.log
}

try-62
