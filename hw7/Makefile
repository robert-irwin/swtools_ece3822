# define a target for the application
#

all: hw7

# define a target to link the application
#
hw7: hw7.o  hw7_00.o
	g++ hw7.o hw7_00.o -o hw7

# define a target to compile the application
#
hw7.0: hw7.cc namelist.h
	g++ -O2 -c hw7.cc -o hw7.o
hw7_00.o: hw7_00.cc namelist.h
	g++ -O2 -c hw7_00.cc -o hw7_00.o

clean:
	rm -f hw7.o hw7_00.o
	rm -f *~