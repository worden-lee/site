# It would be much better if Rout could call R.out, instead of repeating its rules
# But don't fix it soon
%.Rout: %.R
	R --save --no-restore < $< > $@
	- /usr/bin/rename Rplots $*.Rout *.pdf
	- /usr/bin/rename Rplot001 $*.out *.png
	- /usr/bin/rename Rplot $*.out *.png
	- /bin/mv -f .RData $*.Rout.env

# Still trying to figure out why I sometimes get nice pngs


%.Rout.env: %.Rout ;
%.Rout.pdf: %.Rout ;
%.out.png: %.Rout ;

%.Rout.png: %.Rout.pdf
	convert $< $@
