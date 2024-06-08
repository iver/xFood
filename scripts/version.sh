#!/usr/bin/env bash

# DATE=$(date -u "+%Y.%m.%d-%H:%M" | sed "s/\\.0/./g")
# echo "$DATE" > VERSION

grep version mix.exs | head -n 1 | sed 's/[[:space:]]//g' | sed -E 's/\@version//g' | sed -E 's/\"//g' > VERSION