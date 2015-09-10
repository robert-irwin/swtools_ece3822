#!/bin/bash                                                           

##--- Title: hw2.sh                                                     
##--- Description: Completes HW Assignment 01 for ECE_3822                    
##---              This assignment acts as an introduction                    
##---              to bash shell scripting. The tasks are                     
##---              seen throughout the code.                             
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




