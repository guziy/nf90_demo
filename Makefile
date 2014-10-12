FC = s.f90
CC = s.cc



SOURCES_F = $(wildcard *.f90)
OBJ = $(patsubst %.f90, %.o, $(notdir $(SOURCES_F))) 

INC = $(foreach d, $(EC_INCLUDE_PATH), -I$d) -I$(shell nf-config --includedir) 

EXEC_NAME = test.exe

#rmnlib_folder = $(dir $(shell s.locate --lib rmnshared_013))

LIBS = $(shell nf-config --flibs)

default : test

all : $(OBJ) 
	@echo $(OBJ)
	$(FC) $(OBJ) -o $(EXEC_NAME) $(LIBS) 


%.o: %.f90  
	echo $<
	echo $@
	$(FC) $(INC) -c $< -o $@  
	#gfortran -fPIC -c -g $< -o $@





clean:
	rm -f $(OBJ) $(EXEC_NAME)
