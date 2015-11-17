#include "namelist.h"
#include <stdio.h>
#include <string.h>
//Function Definitions                                                        
//Constructor                                                               

NL::DEBUG NL::dbg = NONE;

NL::NL()
{
  
  //check dbg flag
    if (dbg == ALL){
  printf("In Constructor:\n");
  }

  //Initialize to -1 to account for the possibility of an empty file.       
  num_lines = 0;
}


//Destructor
NL::~NL()
{
  if (dbg == ALL){
    printf("In Destructor\n");
  }
  //unallocate memory
  delete [] *str_name;
}

//read_file                                                            
void NL::read_file(FILE* fptr){

  if (dbg == ALL){
    printf("In Read File\n");
  }

  //define an array to hold a line
  char line [100];
  int i = 0;

  //read the file line by line
  while ( fgets ( line, 100 , fptr ) != NULL ){
    // allocate space for each string in memory  
    //store the data where the class variable str_name points to
    str_name[i] = new char[100];
    strcpy(str_name[i], line);
    i++;

  }
  num_lines = i;
}


//sort file
void NL::sort_file(void){
  
  if(dbg == ALL){
    printf("In Sort File\n");
  }

  int i;
  int j;
  char temp[100];
  for (j = 0; j < num_lines; j++){
    for(i = 0; i < (num_lines - 1); i++){
      if(strcmp(str_name[i], str_name[i+1]) > 0){
	strcpy(temp, str_name[i]);
	strcpy(str_name[i], str_name[i+1]);
	strcpy(str_name[i+1], temp);
      	//reset the loop count if something is not in order

      }//end if
      
    }//end for
  }

}


// debug
void NL::debug(){

  if(dbg == ALL){
    printf("In debug\n");
  }

  // print the class data
  fprintf(stdout, "Num lines in file: %d\n", num_lines);
  fprintf(stdout, "Name List:\n");
  for( int i = 0; i < num_lines; i++){
    printf("%s", str_name[i]);
  }
  fprintf(stdout, "DEBUG enum: %d\n", dbg);
}



