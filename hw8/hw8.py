#bin/sys/env python
import sys
import os
import re
import operator
import time

# search function
def searchfile(file):
    # define a count variable
    count = 0

    # initialize a list to hold files containing spike
    spike_files = list()

    # go line by line in the list of files
    for line in file:
        
        #get rid of newline
        line = line.rstrip()

        #open the file given from the list of files
        with open(line, 'r') as fp:
            #loop over the contents of the line
            for line2 in fp:

                #search for spike
                if re.search(r'\bspike\b', line2.lower()):
                    #if we find spike, append the file name to the list
                    spike_files.append(line)
                    
                    #increment the count
                    count = count + 1
                    #we only need to find one instance of spike
                    break
    print "Num files containing spike", len(spike_files)

    return count,spike_files

#---------------
#---------------
#---------------

#histogram function
def onewrd_hist(file_list):
    #initialize a dictionary
    hist = {}

    #loop over every file in the list of files
    for i in range(0,len(file_list)):
        #open the ith file in the list
        with open(file_list[i], 'r') as fp:

            #loop pver the contents of the file by word
            for line in fp:
               
                #make everything lowercase (case-insensitive search)
                line = line.lower()
                
                #get rid of all punctuation
                line = re.sub('[^a-z]+', " ", line)

                for word in line.split():
                    #see if the word is already an entry in the dictionary
                    if not hist.has_key(word):
                        #if the word doesnt exist in the dictionary, add it
                        #to the dictionary and initalize the count as one
                        hist[word] = float(1.0)
                    else:
                        #if the word is already in the dictionary,
                        #increment the current count by one
                        hist[word] = float(hist[word]) + float(1.0)

    # get the total count of words
    hist_list = hist.values()
    total = float(sum(hist_list))

    # redirect stdout
    sys.stdout = open('hista.hist', 'a')

    for i in sorted(hist, key=hist.get, reverse=True):
        value = float(hist[i])
        print("%d %s  %.4f" % (value, i, 100.0*value/total))+"%"
    
    print "\n\n"

#-------------------
#-------------------
#-------------------

# two word histogrm function
def twoword_hist(file_list):
    #initialize a dictionary                                                   
    hist = {}
    #loop over every file in the list of files                                
    for i in range(0,len(file_list)):
        #open the ith file in the list                                           
        with open(file_list[i], 'r') as fp:
            #read the entire file and make it lowercase
            text = fp.read().lower()
            
            #get rid of all punctuation                                 
            text = re.sub('[^a-z]+', " ", text)
            #convert the words into a list where each entry corresponds
            #to a seperate word
            word_list = text.split()
            #iterate over the list, we go one less than the length of word_list
            #because we are looking for two word sequences (word, word+1)
        for i in range(0,len(word_list)-1):
            #make our key for the dictionary
            seq = word_list[i] + " " + word_list[i+1]

            #see if the the two word sequnecy is already in the dctionary
            if not hist.has_key(seq):
                #if the word doesnt exist n the dictionary, add it
                #to the dictionary and initialize the count as one
                hist[seq] = (1.0)
            else:
                #if the word is already in the dictionary,
                #increment the current count by one
                hist[seq] = float(hist[seq]) + float(1.0)

    #find total two word sequences
    hist_list = hist.values()
    total = float(sum(hist_list))

    # redirect stdout to a file
    sys.stdout = open('histbi.hist', 'a')

    #once were done going through all the files, sort and print the dictionary
    for i in sorted(hist, key=hist.get, reverse=True):
        value = float(hist[i])
        print("%d %s  %.4f" % (value, i, 100.0*value/total))+"%"

    
    print "\n\n"


#-------------------
#-------------------
#-------------------            
        
# main program
def main(argv):
    # begin timing it
    start_time = time.time()
    # check for arguments
    # first, lets get argc
    argc = len(argv)

    # if argc = 1, we got no arguments
    if argc == 1:
        sys.exit("Error:\n No Input Arguments")


    #initialize a counter variable 
    total = 0

    # now we can open the file
    #check to see if the file exists
    if os.path.isfile(argv[1]):
        # open the current file
        with open(argv[1], 'r') as f:

            # call our search function
            found,spike_files = searchfile(f)
            #accumulate
            total = total + found

    else:
        # exit if file does not exist
        print "Error:\n %s does not exist", argv[i]
        sys.exit()
        
    #print the number of files contaning spike
    print "Files Containing Spike: ", total
    print "\n\n"

    #now we build the histogram out of all words in the files containing spike
    onewrd_hist(spike_files)

    #now we build the two word histogram
    twoword_hist(spike_files)

    sys.stdout = sys.__stdout__
    # print the total time
    print( "%s seconds" % (time.time()-start_time))







if __name__ == '__main__':
    main(sys.argv[0:])
