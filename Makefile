## This is JD's research sandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Ignore += README.html
Sources += README.md

Ignore += resources
resources/%: resources
resources:
	$(resDrop)

######################################################################

## Bicko pages glitch

README.html.pages:

######################################################################

Sources += $(wildcard *.R *.stan)

autopipeR = defined

######################################################################

## RSA reinfection INACTIVE (see reinfection)
## Read and tidy; save two tidy data frames and a "graphing" frame
rsaRe.Rout: rsaRe.R resources/rsaRe.rds
	$(pipeRcall)

## Some pix
rsaReLook.Rout: rsaReLook.R rsaRe.rda

## Make the analysis frame
rsaRePrep.Rout: rsaRePrep.R rsaRe.rda

## Try to fit
rsaReFit.Rout: rsaReFit.R rsaRePrep.rds
rsaReBin.Rout: rsaReBin.R rsaRePrep.rds
rsaReFitLook.Rout: rsaReFitLook.R rsaReFit.rda

## Checks from Bolker
rsaReTMB.Rout: rsaReTMB.R rsaRePrep.rds

######################################################################

eastCoast.Rout: eastCoast.R
	$(pipeR)

######################################################################

faaJeffries.Rout: faaJeffries.R

## spline bs

nsbs.Rout: nsbs.R

######################################################################

## How does stan work -- it's NUTS!

stanss.Rout: stans.R ss.stan

######################################################################

## Pandoc craziness arising from Chyun's youtube project
Ignore += yt.docx.* yt.docx.md yt.html* yt.html.docx yt.html.md yt.md.* yt.upc.* yt.upc.md yt.xref.md

Sources += youtube.txt all.bib

pfilter = --filter pandoc-xnos

Sources +=  yt.md all.bib

Ignore += yt.pdf
## yt.pdf: yt.md

Ignore += yt.tex
yt.tex: yt.md all.bib
	pandoc  $(pfilter) --bibliography=all.bib --citeproc -s -o $@ $<

## Citation style
Ignore += jmir.csl
jmir.csl:
	curl --output $@ "https://raw.githubusercontent.com/citation-style-language/styles/master/journal-of-medical-internet-research.csl"

xpan = pandoc -s $(pfilter) --bibliography $(filter %.bib, $^) --csl $(filter %.csl, $^) --citeproc -s -o $@ $<

yt.tex.docx: yt.tex jmir.csl all.bib
	$(xpan)

yt.md.docx: yt.md jmir.csl all.bib
	$(xpan)

## Making md from md does not unravel the figure markup
yt.xref.md: yt.md jmir.csl all.bib
	$(xpan)

## html looks nice, but the downstream md has no figure!
yt.html: yt.md jmir.csl all.bib
	$(xpan)

yt.html.md: yt.html
	$(pandocs)

## Nor does the downstream docx? wtf?
yt.html.docx: yt.html
	$(pandocs)

## Try to move the figure caption; this breaks before we even try because the internal figure gets lost
yt.docx.md: yt.md.docx
	$(pandocs)

## FUTURE: pull media from a .docx unzip yt.md.docx word/media/*

Ignore += word media
yt.md.media: %.media: %.docx
	unzip -o $< word/media/*
	mv word/media $@

yt.md.mediadir: %.mediadir: %.media
	$(RM) media
	ln -fs $< media

yt.docx.docx: yt.docx.md yt.md.mediadir
	$(pandocs)

yt.upc.md: yt.docx.md makestuff/upcap.pl
	$(PUSH)

yt.upc.docx: yt.upc.md yt.md.mediadir
	$(pandocs)

yt.Rout: yt.R

######################################################################

## Chaining

impmakeR += xval
## 0.xval.Rout: xval.R
%.xval.Rout: xval.R
	$(pipeR)

impmakeR += square
%.square.Rout: square.R %.rds
	$(pipeR)

impmakeR += halve
%.halve.Rout: halve.R %.rds
	$(pipeR)

impmakeR += print
%.print.Rout: print.R %.rds
	$(pipeR)

11.xval.halve.square.halve.print.Rout:
11.xval.square.halve.print.Rout:

7.xval.halve.square.print.Rout:

######################################################################

## Super-chaining

impPref += prov

## touch prov_ON.R prov_BC.R ##

$(foreach pref,$(impPref),$(eval $(call impPref_r,$(pref))))

define impPref_r
scripts := `ls $(1)_.*.R`
scripts := $(basename scripts)
endef


######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

-include makestuff/pipeR.mk
-include makestuff/pandoc.mk
-include makestuff/texi.mk

-include makestuff/git.mk
-include makestuff/visual.mk
