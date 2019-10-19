#!/bin/bash

echo 'building...' >&2 \
&& docker build -t test "$(dirname "$0")" \
&& echo '-------------------------------------------------------------------------------' >&2 \
&& echo 'testing...' >&2 \
&& docker run -it --rm --name test test

