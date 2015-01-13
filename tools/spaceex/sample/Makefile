
INCLUDEDIR	= ../include
LIB		= spaceex
LIBDIR		= ../lib
LDFLAGS		= -L$(LIBDIR) -l$(LIB) -lnlopt -lppl -lboost_program_options -lglpk -lcolamd -lamd
CFLAGS		= $(LDFLAGS) -I$(INCLUDEDIR)

EXECUTABLE	= test
RUNSCRIPT	= run.sh
COBJECTS	= $(EXECUTABLE)
OBJECTS		= $(COBJECTS) $(RUNSCRIPT)
CC		= g++


all: $(OBJECTS)

$(COBJECTS): $(addsuffix .o,$(COBJECTS))
	$(CC) -L$(LIBDIR) $? -l$(LIB) -lnlopt -lppl -lboost_program_options -lglpk -lcolamd -lamd -o $@

$(addsuffix .o,$(COBJECTS)): $(addsuffix .cpp,$(COBJECTS)) $(INCLUDEDIR)/sspaceex_api.h
	$(CC) $(CFLAGS) -c $(@:%.o=%.cpp) -o $@

run: $(RUNSCRIPT)
	./run.sh

$(RUNSCRIPT): $(EXECUTABLE)
	@echo "Generating run-script..."
	@echo "$$RUNSCRIPTCONTENT" > run.sh
	@chmod +x run.sh
	@echo "Done. Type make run to run."

clean:
	rm -rf $(OBJECTS) $(addsuffix .o,$(COBJECTS))

.PHONY:	all clean run

###############################################################################

# Var definitions
define RUNSCRIPTCONTENT
#!/bin/bash

LD_LIBRARY_PATH=$$LD_LIBRARY_PATH:$(LIBDIR)/ ./$(EXECUTABLE)
endef
export RUNSCRIPTCONTENT
