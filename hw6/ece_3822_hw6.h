#ifndef HEADER_SEEN
#define HEADER_SEEN
#include <stdio.h>
#include <stdlib.h>

#define NBYTES 1024
//function declarations
void read_sig(FILE* signal, int num_bytes, int mode, int numbers);


//function definitions
void read_sig(FILE* signal, int num_bytes, int mode, int numbers){
  //local variables
  int bytes_read;
  int count = 0;
  int i;

  if(mode == 0){
    short int data[num_bytes];
    int size = sizeof(short int);
    bytes_read = NBYTES;
    printf("Reading data as 16-bit integers...\n");

    //we do this until bytes_read = num_bytes.
    //when these are not equal, we have reached the end of the file

    while(bytes_read == num_bytes){
      bytes_read = fread(data,size,num_bytes,signal);

      if(numbers == 0){
       for(i = 0; i<bytes_read; i++){
     	 fprintf(stdout, "%d\n", data[i]);
       	 count = count + 1;
       }
      }
      //this is how we display the numbers
      else{
	for(i = 0; i<bytes_read; i++){
       	  fprintf(stdout, "%07d: %d\n",count, data[i]);
	  count = count + 1;
	}
      }


    }
  }
    else{
      float data[num_bytes];
      int size = sizeof(float);
      printf("Reading data as 4 byte floating point numbers...\n");

      bytes_read = num_bytes;
      while(bytes_read == num_bytes){
	bytes_read = fread(data,size,num_bytes,signal);

	if(numbers == 0){
	  for(i = 0; i<bytes_read; i++){
	    fprintf(stdout, "%.8e\n", data[i]);
	    count = count + 1;
	  }
	}

	  else{
	    for(i = 0; i<bytes_read; i++){
	      fprintf(stdout, "%07d: %.8e\n",count, data[i]);
	      count = count + 1;

	    }
	  }

	}
      }
    


  }



#endif

