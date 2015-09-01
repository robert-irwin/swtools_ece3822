#!/bin/bash

##--- Title: count.sh                                                                                                                                                          
##--- Description: Completes HW Assignment 01 for ECE_3822
##---              This assignment acts as an introduction
##---              to bash shell scripting. The tasks are 
##---              seen throughout the code.

##---              *NOTE:* 
##---              Part 1 of the assignment is not 
##---              included because it involved adjusting the
##---              default bath in the .bash_profile
##--- Author:      Robert Irwin








# 2) Count the total number of directories in the database.
#       Count the total number of files. Count the number
#       of sessions that have a first name that begins with
#       “R” and a last name that begins with “S” and 
#       occurred between 2010 and 2013.

#clean up .hist files if this was ran before
rm -f suba.hist subb.hist bi.hist  

FILECOUNT=0;
DIRCOUNT=0;

# Beginning searching and counting for
# all files and directories
find "../data" -type f > files.txt
FILECOUNT="$(wc -l < files.txt)"    
find "../data" -type d > output.txt
DIRCOUNT="$(wc -l < output.txt)"


echo "File count: " $FILECOUNT
echo "Directory count: " $DIRCOUNT

# Search for dates and first/last/ names
# This is done in steps and each of the search results
# of each search are written to a txt file to
# verify the output

grep "/R" output.txt > out1.txt
grep "_S" out1.txt > out2.txt
grep "2010\|2011\|2012\|2013" out2.txt > final.txt

FILECOUNT="$(wc -l < final.txt)"

echo "Files that match search criteria: " $FILECOUNT


#now we are concerned with the files

#flags for grep
   #-i ignores case
   #-R recursive search
   #-l stops searching a file after 1 instance of pattern
   #-E allows search of multiple patterns IF ALL patterns are in the file

#  3)  Count the number of files in the database that have the word “spike”
#      occurring at least once. Call this subset “A”. Repeat this for files
#      containing the word “seizure,” which we will refer to as subset B.
#      Produce a histogram of the distribution of these words in subsets
#      A and B, listing the most frequently occurring first and least
#      frequently occurring last. Show both the absolute counts and the
#      percentage (often referred to as the cumulative distribution).

grep -iRlw "spike" /Users/robertirwin/software_tools/data/* > suba.txt
SPIKE="$(wc -l < suba.txt)"
echo "Files with <spike>: " $SPIKE
grep -iRlw "seizure" /Users/robertirwin/software_tools/data/* > subb.txt
SEIZURE="$(wc -l < subb.txt)"
echo "Files with <seizure>: " $SEIZURE

echo "Creating Histogram of subset A..."
xargs cat < suba.txt | tr -sc '[A-Z][a-z]' '[\012*]' > suba.words
sort -f suba.words | uniq -ci | sort -nr > suba.hist

#pdf                                                                        
sed 's/^ *//g' < suba.hist > suba1.hist
cut -f 1 -d ' ' suba1.hist > num.list

#sum up all histogram entries                                                 
sum=$(awk '{SUM += $1} END { print SUM}' num.list)

file='num.list'
lines=`cat $file`
#calculate perentages                                                         
for num in $lines;
do
   percent=`awk  'BEGIN{printf("%0.4f", '$num' / '$sum' *100)}'`
   echo "$percent%" >> per.list
done

#now we simply paste the lists                                             
paste suba.hist per.list > hista.hist
rm per.list num.list
echo "Done... saved in hista.hist"

echo "Creating Histogram of subset B..."
xargs cat < subb.txt | tr -sc '[A-Z][a-z]' '[\012*]' | sort -f | uniq -ci | sort -nr > subb.hist

#pdf                                                                        
sed 's/^ *//g' < subb.hist > subb1.hist
cut -f 1 -d ' ' subb1.hist > num.list
#sum up all histogram entries             
sum=$(awk '{SUM += $1} END { print SUM}' num.list)

file='num.list'
lines=`cat $file`
#calculate perentages                                                   
for num in $lines;
do
   percent=`awk  'BEGIN{printf("%0.4f", '$num' / '$sum' *100)}'`
   echo "$percent%" >> per.list
done
#now we simply paste the lists                    
paste subb.hist per.list > histb.hist

rm per.list num.list
echo "Done... saved in histb.hist"


#  4)  For Subset A, produce a histogram of all two-word sequences that 
#      occur in this subset of the database

echo "Creating Histogram of all two word sequences in subset A..."
tail -n +2 suba.words > suba.next

#Merge the two lists
paste suba.words suba.next | sort -f | uniq -ci | sort -nr > bi.hist
sed 's/^ *//g' < bi.hist > bi1.hist
cut -f 1 -d ' ' bi1.hist > num.list
#sum up all histogram entries                                               
sum=$(awk '{SUM += $1} END { print SUM}' num.list)

file='num.list'
lines=`cat $file`
#calculate perentages                                                          

for num in $lines;
do
   percent=`awk  'BEGIN{printf("%0.4f", '$num' / '$sum' *100)}'`
   echo "$percent%" >> per.list
done
#now we simply paste the lists                            
paste bi.hist per.list > histbi.hist


echo "Done... saved in histbi.hist"
#Clean up files                                                              
rm output.txt out1.txt out2.txt final.txt files.txt suba.txt subb.txt suba.words suba.next suba.hist subb.hist per.list
