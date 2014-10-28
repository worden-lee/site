# All a mess; multi-page convert is misbehaving!

%.Rout.0.png %.Rout.1.png %.Rout.2.png %.Rout.3.png %.Rout.4.png %.Rout.5.png %.Rout.6.png %.Rout.7.png %.Rout.8.png %.Rout.9.png: %.Rout %.Rout.pdf
	convert $<.pdf $<.%d.png

%.Rout-0.png %.Rout-1.png %.Rout-2.png %.Rout-3.png %.Rout-4.png %.Rout-5.png %.Rout-6.png %.Rout-7.png %.Rout-8.png %.Rout-9.png: %.Rout-%.Rout.pdf
	convert $<.pdf $<-%d.png

%.Rout-0.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-1.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-2.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-3.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-4.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-5.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-6.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-7.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-8.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout-9.png: %.Rout
	$(MAKE) $<.png
	/bin/ln -fs $< $@

%.Rout.0.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.1.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.2.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.3.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.4.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.5.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.6.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.7.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.8.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png

%.Rout.9.png: %.Rout
	$(MAKE) $<.pdf
	/bin/rm -f $@
	convert $<.pdf $<.png
