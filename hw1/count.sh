#!/bin/bash
FILECOUNT=0;
DIRCOUNT=0;


find "../data" -type f > files.txt
FILECOUNT="$(wc -l < files.txt)"    
find "../data" -type d > output.txt
DIRCOUNT="$(wc -l < output.txt)"

echo "File count: " $FILECOUNT
echo "Directory count: " $DIRCOUNT

#Search for dates and first/last/ names
grep "/R" output.txt > out1.txt
grep "_S" out1.txt > out2.txt
grep "2010\|2011\|2012\|2013" out2.txt > final.txt

FILECOUNT="$(wc -l < final.txt)"

echo "Files that match search criteria: " $FILECOUNT

#delete files we no longer care about
rm output.txt out1.txt out2.txt final.txt files.txt

#now we are concerned with the files

#flags for grep
   #-i ignores case
   #-R recursive search
   #-l stops searching a file after 1 instance of pattern
   #-E allows search of multiple patterns IF ALL patterns are in the file

SPIKE="$(grep -iRlw "spike" /Users/robertirwin/software_tools/data/* | wc -l)" 
echo "Files with <spike>: " $SPIKE
SEIZURE="$(grep -iRlw "seizure" /Users/robertirwin/software_tools/data/* | wc -l)"
echo "Files with <seizure>: " $SEIZURE

echo "Creating Histogram of the occurences of all words in the files containingthe word <spike>..."
xargs | cat `grep -iRlw "spike" /Users/robertirwin/software_tools/data/*` | tr -sc '[A-Z][a-z]' '[\012*]' | sort -nr | uniq -c > spike.hist



