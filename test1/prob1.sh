#!/bin/bash

#--- Title:       Prob1.sh
#--- Description: Searches a path for files containg spike AND sustained
#---              made in May 1-30 2007 and counts the number of files
#---              that match
#--- Author:      Robert Irwin

grep -iRl "spike" /Users/robertirwin/software_tools/data/* | xargs grep -ilR "sustained" > filter.txt

#This is for testing
#grep -iRl "spike" /Users/robertirwin/software_tools/test1/testprob1/* | xargs grep -ilR "sustained" > match.list

grep "200705[0-2][0-9]" filter.txt > mid.list 
grep "20070530" mid.list > mid1.list
cat mid.list mid1.list > match.list
COUNT="$(wc -l < match.list)"

echo "Number of Files that match: " $COUNT

#file cleanup
#rm filter.txt mid.list mid1.list
