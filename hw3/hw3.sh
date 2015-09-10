#!/bin/sh

##---    Title:       hw3.sh
##---
##---    Description: Takes a list of songs and shuffles
##---                 them with a custom algorithm.  After the program
##---                 is killed, it will pick up where it left off. Even after this 
##---                 program is killed, all songs in the playlist must be played once
##---                 before any song can be played twice.  This is meant to run in
##---                 in the background. type sh hw3.sh & to accomplish this.  See 
##---                 irwin_robert_hw3.docx located in this repo to skip songs and stop the music.
##---
##---    Author:      Robert Irwin

true=1

while [ $true ]
do
    #We want to see how many songs we are working with
    size="$(ls songs | wc -l)"
    
    #We will keep track of our progress by grepping for num.list
    #If num.list exists, we know the program has been run.  We then print
    #out the contents of the file and search it for any number.  If we find a number,
    #we leave num.list the way it is.  We then set count to the length of the list + 1
    ls > check.txt
    check="$(grep 'num.list' check.txt | wc -l)"
    echo "CHECK = " $check
    if [ $check == 1 ]; then
        check2="$(cat 'num.list' | grep -m 1 [0-9] | wc -l)"
        if [ $check2 == 1 ]; then
            num="$(cat 'num.list' | wc -l)"
            COUNT=`expr $num + 1`
        else
            #Generate a list of ordered numbers from 1-#of_files
            seq 1 $size > num.list
            #Add 1 because of modulo operation.
            COUNT=`expr $size + 1`
        fi
    else
           #Generate a list of ordered numbers from 1-#of_files                                       
            seq 1 $size > num.list
            #Add 1 because of modulo operation.                                   
            COUNT=`expr $size + 1`
    fi

    for i in {1..$size}
    do
        #Generate the random number
        #This is done by modulating a number by 101, to ensure we get a number from 1-100
        
        #COUNT is decremented each time through the loop.
        #This is because the number of the song that was played is removed from
        #num.list.  Count is then decremented so the random number generated
        #cannot exceed the amount of numbers left in the list.
        #This is how we ensure that every song is played once before
        #any song is played twice
        sec="$(date +%S)"
        min="$(date +%M)"
        echo "Seconds: " $sec
        echo "Minutes: " $min
	SUM=`expr $sec + $min`
	SUM1=`expr $SUM + $sec`
	RAND=`expr $SUM1 % $COUNT`
        #Make sure Rand doesn't equal 0

	if [ $RAND == 0 ]; then
	    RAND=1
	fi
	echo "Sum: " $RAND

        #Now we work wit the numbered list.  This is how we assure that 
        #no song is played twice before every song is played once
        
        #get the number of the song we want to play
        #It is important to remeber that the song number we 
        #will play corresponds to the NUMBER on the line dictated
        #by RAND.
        songnum="$(head -$RAND num.list | tail -1)"
        #get the song that corresponds to that number
        songname="$(ls songs | head -$songnum | tail -1)"
        echo "Songnum: " $songnum
        echo "Songname: " $songname
        COUNT=`expr $COUNT - 1`
        echo "Count : " $COUNT
        #delete the chosen number from the list of numbers so no song cant be played twice                                                                                      
        sed "s/[[:<:]]$songnum[[:>:]]//" num.list | sed '/^\w*$/d' > temp.list
        cat temp.list > num.list
        #Now we play he song
        mpg123 songs/$songname
    done
done