# ATTENTION! DO NOT UPDATE THIS FILE!  IT HAS BEEN REPLACED BY
# makefile-before AND makefile-after.

CC = gcc
PUSH = perl -wf $(filter %.pl, $^) $(filter-out %.pl, $^) > $@

TEXINPUTS = .:$(SITE_RESOURCES)/tex:
export TEXINPUTS

# site-specific rules for lalashan ProjectExtension installation

######################################################

# R stuff

PDFCHECK = perl -wf $(SITE_RESOURCES)/pdfcheck.pl $@
RR = $(SITE_RESOURCES)/Rprep.pl
Rtrim = $(SITE_RESOURCES)/Rtrim.pl

# rename stuff still needs work; eventually don't use rename, but teach Rprep.pl
define run-R 
	perl -f $(RR) $@ $^ > $(@:.Rout=.RR)
	R --vanilla < $(@:.Rout=.RR) > $(@:.Rout=.dmp)
	perl -wf $(Rtrim) $(@:.Rout=.dmp) > $@
	$(RM) $(@:.Rout=.RR) $(@:.Rout=.dmp)
	/bin/mv -f Rplots.pdf $(@:.Rout=.Rout.pdf)
	- /usr/bin/rename .pdf .Rout.pdf Rplot*.pdf
	- /usr/bin/rename Rplots $* *.pdf
	/bin/mv -f .RData $(@:.Rout=.RData)
endef

%.Rout: %.R
	$(run-R)

# Need to suppress this until we can give it a lower priority?
# %.Rout:
#	 $(run-R)

%.Rout.pdf: %.Rout 
	$(PDFCHECK) 

%.Rout.png: %.Rout.pdf
	/bin/rm -f $@
	convert $<[0] $@

%.Routput: %.Rout
	perl -f $(SITE_RESOURCES)/Rcalc.pl $< > $@ 

%.RData: %.Rout ;

######################################################

# Old R stuff

# These rules still work, but this one needs to be re-enabled in some directories (by copying it to a local make file):

# %.R:
#	echo "# Empty automatic R file" > $@

%.out: % # Cancel bizarre suffix rule

# New figure philosophy.  RR.pl uses pdf.  You can specify png if you want; this will generate a png with no .R in the middle.  .R.png is generated automatically via pdf (usually should not be a problem)

%.R.out: %.R
	perl -f $(SITE_RESOURCES)/RR.pl $@ $^ > $*.RR
	R --vanilla < $*.RR > $*.R.dmp
	perl -wf $(SITE_RESOURCES)/Rtrim.pl $*.R.dmp > $*.R.out
	$(RM) $*.RR $*.R.dmp
	- /usr/bin/rename Rplots .$*.R *.pdf
	- /usr/bin/rename Rplot001 .$* *.png

%.R.calc: %.R.out
	perl -f $(SITE_RESOURCES)/Rcalc.pl $< > $@ 

%.R.env: %.R.out ;
%.R.pdf: %.R.out
	cp -f .$@ $@

%.R.png: %.R.pdf
	convert $< $@

# %.png: %.R.out
	# mv .$@ $@

# Move Rout stuff to Rout.mk suddenly

%.ps : %.pdf
	convert $< $@

######################################################

# Maxima

# Tell maxima how to find maxima-init.mac
export MAXIMA_USERDIR=$(SITE_RESOURCES)

# Maxima
%.mac.out: %.mac
	$(SITE_RESOURCES)/mx.pl $@ $^ > $*.mx
	maxima -b $*.mx | $(SITE_RESOURCES)/mxtrim.pl > $@
	- /usr/bin/rename maxima_plot .$*.mac *.ps

%.mxv: %.mac.out ;
%.mac.ps: %.mac.out
	mv .$@ $@

# ps seems to be prettier than png
# %.png: %.mac.out ;

%.mac:
	echo "/* Automatic empty maxima file */" > $@

###################################################################

# DMU

DMU = ../../projects/Theobio%2Fdmu

%.tab.tex: %.tsv %.tmp
	perl -wf $(DMU)/dmu.pl $^ $(DMU)/tab.fmt > $@

# .fmt and .tmp files are local!  Eventually, put them in a permanent location.
# Eventually add locations of permanent .fmt and .tmp files? What about supplementary .fmt file?
%.tex: %.let letter.fmt letter.tmp
	perl -wf $(DMU)/dmu.pl $^ > $@

%.article.tex: %.tex
	echo "\documentclass[12pt]{article}\begin{document}" > $@
	cat $< >> $@
	echo "\end{document}" >> $@

######################################################

# Refs

REF = ../../projects/Refs/

%.rmu: %.rr $(REF)/rr.pl
	$(PUSH)

%.bib: %.rmu $(REF)/pm.pl
	$(PUSH)

# %.rmu dependency is so that this rule is not invoked by other attempts to make wikitext
%.wikitext: %.rmu %.bib ;

%.raw.bib: %.rmu $(REF)/rawbib.pl
	$(PUSH)

%.comp.bib: %.bib %.raw.bib
	cat $^ > $@

######################################################

# Gimmicks

# Word counts

%.wc: %
	wc $< > $@
