FC = s.f90
CC = s.cc



SOURCES_F = $(wildcard *.f90)
OBJ = $(patsubst %.f90, %.o, $(notdir $(SOURCES_F))) 

INC = $(foreach d, $(EC_INCLUDE_PATH), -I$d) -I$(shell nc-config --includedir)

EXEC_NAME = test.exe

#rmnlib_folder = $(dir $(shell s.locate --lib rmnshared_013))

LIBS = $(shell nc-config --libs) -lnetcdff 

all : $(OBJ) 
	@echo $(OBJ)
	$(FC) $(OBJ) -o $(EXEC_NAME) $(LIBS) 


%.o: %.f90  
	echo $<
	echo $@
	$(FC) -c $< -o $@  
	#gfortran -fPIC -c -g $< -o $@





clean:
	rm -f $(OBJ) $(EXEC_NAME)
