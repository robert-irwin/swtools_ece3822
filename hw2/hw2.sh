#!/bin/bash                                                           

##--- Title: hw2.sh                                                     
##--- Description: Completes HW Assignment 02 for ECE_3822                    
##---              This assignment involves writing a script                 
##---              that writes a script that renames a large 
##---              number of files.
##--- Author:      Robert Irwin                          

FILES=$1

#count="$(wc -l < $FILES)"
sed 's/^//' $FILES > temp.list
i=0;

FILENAME='temp.list'
lines=`cat $FILENAME`
for x in $lines
do
    count=`printf "%07d" $i`
    echo "cp $x /Users/tmp/bob_$count" 
    i=`expr $i + 1`
done 




