//create an include gaurd to avoid possible
//double declarations
//
#ifndef HEADER_SEEN
#define HEADER_SEEN

//bring in standard libraries
//
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
//create class
//
class NL {

//protected data
//
protected:

  char* str_name[100];
  int num_lines;

//public data
//
public:

  // Constructor
  //
  NL();
  
  //Destrcutor
  //
  ~NL();
  
  //define an enum directly available to all functions
  //that import this header
  // 
  enum DEBUG {NONE = 0, ALL};
  static DEBUG dbg;
  

  //Function Declarations
  void read_file(FILE*);
  void sort_file(void);
  void write_file(void);
  void debug(void);
};
//end of class


#endif
