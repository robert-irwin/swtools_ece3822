#include "ece_3822_hw6.h"
#include <string.h>
#include <unistd.h>

int main(int argc, char* argv[]){

  //define local variables

  int k;
  int status;
  int i_flag;
  int f_flag;
  FILE* fp;
  FILE* fp_pipe;
  int linenum_flag;
  int bytes_read;
  int i;

  //first we make sure the user passed us an argument
  if((argc == 1) && (isatty(fileno(stdin)))){//the 2nd checks for piped inputs
    printf("\nError: No arguments Specified\n");
    printf("For help with this function, pass <-h> as an argument to this function\n");
    exit(EXIT_FAILURE);
  }

  //set status to default this represents interpreting the data 16-bit integer mode
  //a status of 1 corresponds to 4-byte floating point number form 
  status = 0;
  //initialize argument flags
  i_flag = 0;
  f_flag = 0;

  //Now we check for flags being passed
  for( k = 1; k <= (argc-1); k++){
    if(strcmp(argv[k],"-h")==0){
      if(k > 4){
	printf("\nError: Invalid Syntax\nType <print_signals -h> for more information.\n");
	exit(EXIT_FAILURE);
      }
      printf("\n\n*Help Page for PRINT_SIGNALS:*\n\n");
      printf("This program prints the values of the signal passed to it. If the\n");
      printf("-numbers argument is passed, it will display the sample number next to\n");
      printf("the sample value.\n\n");
      printf("PRINT_SIGNALS has the general format:\n");
      printf("print_signals [-h -numbers -i -f] file1.raw file2.raw...\n\n");
      printf("The -h option brings up this help menu.\n");
      printf("The -f option interprets the data as a 4-byte floating point number.\n");
      printf("The -i option interprets the data as 16-bit integers.\n");
      printf("If the -i and -f options are specified, the program will operate according\n");
      printf("to the latter.\n");
      printf("By default, the program interprets data as 16-bit integers.\n\n");
      printf("*NOTE:* An option must be one of the first 4 arguments to this function.\n");
      printf("If not, an invalid syntax error will occur.\n\n");
      }

    //if -f and -i have been passed, figure out which one was passed last
    if(strcmp(argv[k],"-i")==0){
      if(k > 4){
	printf("\nError: Invalid Syntax\nType <print_signals -h> for more information.\n");
	exit(EXIT_FAILURE);
      } 

      i_flag = k;
     }
    
    if(strcmp(argv[k],"-f")==0){
      if(k > 4){
	printf("\nError: Invalid Syntax\nType <print_signals> -h for more information.\n");
	exit(EXIT_FAILURE);
      } 

      f_flag = k;
    }
    
    if(strcmp(argv[k],"-numbers")==0){
      if(k > 4){
	printf("\nError: Invalid Syntax\nType <print_signals> -h for more information.\n");
        exit(EXIT_FAILURE);
      }
    
      //This variable will be passed to read_signal to determine if we will print the
      //line numbers beside each data point
      linenum_flag = 1;
    }

  }//end for loop
  

  //check to see if only the -h option is displayed
  if((argc == 2) && (strcmp(argv[1],"-h")==0)){
    exit(EXIT_SUCCESS);
  }
 if( f_flag > i_flag ){
   status = 1;
 }
 
 //look for input from pipes and pass them to our read function            
 printf("output of fileno: %d\n", fileno(stdin));
 printf("output of isatty: %d\n", isatty(fileno(stdin)));
 if(!isatty(fileno(stdin))){
   
   fprintf(stdout, "reading from stdin...\n");
   read_sig(stdin, NBYTES, status, linenum_flag);
   // fclose(fp_pipe);
 }

 //now we decide what reading mode we are in based off the value of status

   for(k=1; k <= (argc-1); k++){

     //loop through every command line argument.  If it returns NULL, move to the next one.
     fp = fopen(argv[k],"rb");

     if((fp == NULL) && (strcmp(argv[k],"-i")!=0) && (strcmp(argv[k],"-h")!=0)){
       if((strcmp(argv[k],"-f")!=0) && (strcmp(argv[k],"-numbers")!=0)){
	 fclose(fp);
	 printf("No Such File <%s>.  Program Terminated.\n\n", argv[k]);
	 exit(EXIT_FAILURE);
       }
     } //end if
     else{
       printf("Data from file: %s\n", argv[k]);
       read_sig(fp, NBYTES, status, linenum_flag);
       fclose(fp);
     }

   }//end for
 

//exit gracefully
}  
