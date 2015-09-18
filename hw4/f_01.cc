//--- Name:         f_01.cc
//--- Description:  Contains function ece_3822_add_sin that
//---               takes two floating point numbers and returns
//---               the sum of the sin of each value using the sin
//---               function in math.h
//--- Author:       Robert Irwin

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

float ece_3822_add_sin(float x, float y){
  printf("Enter First Number: ");
  scanf("%f",&x);
  printf("Enter SecondNumber: ");
  scanf("%f",&y);
  float sum_sines;
  sum_sines = sinf(x)+sinf(y);
  printf("The sum of sines is %f\n", sum_sines);
  return sum_sines;
	   }
