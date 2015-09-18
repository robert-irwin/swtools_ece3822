//--- Name:          foo.00
//--- Description:   Main Program.  Prints "Hello World"
//---                and calls ece_3822_add_sin.
//--- Author:        Robert Irwin

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// function definition
float ece_3822_add_sin(float x, float y);


int main(void){
  //local variables
  float sum, x, y;

  printf("Hello World\n");
  sum = ece_3822_add_sin(x,y);
  return 0;
    }
