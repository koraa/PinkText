#!/bin/sh

set -e

FILE="$1"

for COMMIT in $(git rev-list HEAD -- $1 | tac); do
    printf "commit-author "
    git --no-pager show -s --format="%an" $COMMIT
    
    printf "commit-time "
    git --no-pager show -s --format="%at" $COMMIT

    printf "commit-message "
    git --no-pager show -s --format="%s" $COMMIT
done
