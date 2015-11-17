#include "namelist.h"

//main
int main(int argc, char** argv){

  //instantiate the class object


  //look for command line arguments
  //flags for command line parsing
  
  //check if we got arguments
  if (argc == 1){
    fprintf(stdout,"No Input Specified.\nUse ./hw7 -h for help.");
    return(EXIT_FAILURE);
  }

  int hflag =0;
  int dflag =0;
  int sflag =0;
  int c;
  
  opterr = 0;

  //set appropriate flags to 1
  while ((c = getopt (argc, argv, "hds")) != -1 )
    switch (c)
      {
      case 'h':
	hflag =1;
	break;
      case 'd':
	dflag =1;
	break;
      case 's':
        sflag = 1;
	break;
      }
  
  //print our help file on command
  if(hflag == 1)
    {
      printf("help file:\n");
      printf("hw_07 prints file to standard out\n");
      printf("-s option sorts output in alphabetical order\n");
      printf("-h displays help file\n");
      printf("-d adds debug status as the program is running\n");
      return(EXIT_SUCCESS);
    }

  //debug flag handling
  if(dflag == 1)
    {
      // set debug flag high
      NL::dbg = NL::ALL;
    }

  //open file
  FILE* fp = fopen(argv[optind], "r");
  
  //check contents of the file
  if(fp == NULL){
    printf("Error: No such file %s,\n or %s is empty.\n", argv[optind], argv[optind]);
    return(EXIT_FAILURE);
      }
  
  //instantiate the class instance
  NL tname;

  //read in the file
  tname.read_file(fp);

  //if sort flag is thrown, call sort
  if( sflag == 1){
    
    tname.sort_file();
  }

  //print the class data
  tname.debug();

//exit gracefully
}
