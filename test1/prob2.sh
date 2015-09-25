#!/bin/bash

#--- Title:       prob2.sh
#--- Description: Finds all files with "John" in the name and
#---              counts the total number of characters in all the files.
#--- Author:      Robert Irwin

find "../data" -type f > files.txt

#This is for testing
#find "/Users/robertirwin/software_tools/test1/testprob1" -type f > output.txt

grep "John" files.txt > output.txt
TOTAL="$(wc -l < output.txt)"
string='output.txt'
lines=`cat $string`
count=0

for x in $lines
do
    echo "FileName: " $x
    i="$(cat $x | wc -m)"
    echo "Characters in File: " $i
    count=`expr $count + $i`
    echo ""
done 
echo "Total Number of Characters: " $count
echo "Total Number of Files Processed: " $TOTAL

#file cleanup
#rm files.txt output.txt