#!/bin/bash
CACHE=$1
BASE=$2
FILES=$(ls $BASE/*.pk3)
for FILE in $FILES; do
    FILE=$(basename $FILE)
    if ! test -d $CACHE/$FILE; then
        mkdir $CACHE/$FILE
        unzip -q $BASE/$FILE "levelshots/*" -d $CACHE/$FILE
        mogrify -resize "256x256!" "$CACHE/$FILE/levelshots/*.jpg"
    fi
done