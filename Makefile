## This is JD's research sandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += README.md

Ignore += resources
resources/%: resources
resources:
	$(resDrop)

######################################################################

Sources += $(wildcard *.R)

autopipeRcall = defined

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

## Pandoc craziness arising from youtube

Sources += youtube.txt all.bib

yt.html: yt.md
	$(pandoc)

pfilter = --filter pandoc-xnos

## yt.pdf: yt.md
yt.tex: yt.md all.bib
	pandoc --bibliography=all.bib $(pfilter) --citeproc -s -o $@ $<

ms.brute.tex: ms.md all.bib
	pandoc --bibliography=auto.bib $(pfilter) --citeproc -s -o $@ $< \
	|| pandoc --filter pandoc-citeproc $(pfilter) -s -o $@ $<

yt.Rout: yt.R

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
