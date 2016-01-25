# the "step" concept is a general one: a file named X.ext.step is
# equivalent to a script named X.ext except that it has special
# comment lines saying what it depends on and what depends on it:
# this saves the effort of writing makefile rules for each step
# of the computation.

# where are we?  If we're being called by a project that knows us as
# $(BoxModels) then we know where we are, otherwise suppose that . is 
# the right path for finding step.pl
BoxModels ?= .

# .step files are all processed about the same, but they need one
# rule per filetype because of different languages' comment syntax.
# This is the rule for making a .sage.step file into a script-makefile pair.
%.sage %.sage.mk : %.sage.step $(BoxModels)/step.mk $(BoxModels)/step.pl
	perl -f $(BoxModels)/step.pl $*.sage '#'

%.py %.py.mk : %.py.step $(BoxModels)/step.mk $(BoxModels)/step.pl
	perl -f $(BoxModels)/step.pl $*.py '#'

# Here we infer what .step files to process, and invoke the makefiles
# they produce.
WW_STEP_SOURCE_FILES = $(filter %.step,$(WW_THIS_PROJECT_SOURCE_FILES))
WW_STEP_MK_FILES = $(patsubst %.step,%.mk,$(WW_STEP_SOURCE_FILES))
$(info Including .mk files from .step files: $(WW_STEP_MK_FILES))
include $(WW_STEP_MK_FILES)
