#!/bin/bash

#--- Title:       prob3.sh
#--- Description: Exports the name of the OS and Processor of your system as
#---              environment variables.
#--- *NOTE*:      Run script with ../prob3.sh or source ./prob3.sh
#--- Author:      Robert Irwin
 
export MY_OS=$(uname -s)
export MY_PROC=$(uname -p)
