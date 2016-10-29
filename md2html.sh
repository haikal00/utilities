#!/bin/bash

# this script will convert all *.md files (assumed that it has markdown syntax)
# to self-contained html formatted document in "output" directory at the same
# level of where this script reside.
# uncomment the below setting to see what happen behind the screen

# tested on Ubuntu 16.04 LTS (xenial)
# prerequisite: 
# pandoc   : sudo apt-get install pandoc
# pygments : sudo pip install pygments

# to see what you can write in your markdown page:
# man pandoc 

# set -x
DIR=$(dirname $0)
TARGET_DIR="$(dirname $DIR)/output"

echo "start converting: $DIR to $TARGET_DIR"
cd $DIR
for f in `find . -name '*.md'`
do 
   TBASEDIR=$(dirname $f)
   FILENAME=$(basename $f)
   LEN=${#FILENAME}
   END_IDX=$[$LEN-3]
   OUTPUTFILE="${FILENAME:0:$END_IDX}.html"
   OUTPUTDIR="${TARGET_DIR}${TBASEDIR:1}"
   OUTPUTFILEPATH="$OUTPUTDIR/$OUTPUTFILE"
   if [ ! -d $OUTPUTDIR ]; then
   	   mkdir $OUTPUTDIR
   fi
   echo "writing ${f:2} to $OUTPUTFILEPATH"
   pandoc -s $f -o $OUTPUTFILEPATH
done