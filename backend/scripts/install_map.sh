#!/bin/bash
FILE=$1
BASE=$2
# check if source file exists
if test -f $FILE; then
    # check if there is a screenshot of a map in the pk3
    MAPS=$(unzip -l $FILE | grep levelshots | sed 's/^.*levelshots\///' | sed 's/\.jpg$// | wc -l')
    if [[ $MAPS = "0" ]]; then
        echo 400
    else
        # copy the new map over and fix its permissions
        cp $FILE $BASE/AAAA-$(basename $FILE).pk3 && chmod 644 $BASE/AAAA-$(basename $FILE).pk3 && echo 200 || echo 500
    fi
else
    echo 404
fi