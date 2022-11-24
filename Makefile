## This is JD's research sandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session: bash -cl "vmt"

######################################################################

Ignore += README.html Sources += README.md

Ignore += resources resources/%: resources
resources:
	$(resDrop)

######################################################################

alldirs += trains

## Bicko pages glitch

README.html.pages:

######################################################################

## Miriam math

bigsin.Rout: bigsin.R

Sources += $(wildcard *.mac)
Ignore += *.mac.out

derivative.mac.out: derivative.mac
	maxima -b $< > $@

critical.Rout: critical.R

######################################################################

Sources += $(wildcard *.R *.stan)

autopipeR = defined

######################################################################

Sources += frinda.tex
Ignore += frinda.html
frinda.html: frinda.tex
	pandoc $< -t html -s --mathjax -o $@

frinda.pdf: frinda.tex
	$(pandocs)

poly.Rout: poly.R

######################################################################

curve.Rout: curve.R

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
## Failing in a very frustrating way (eval doesn't know special variable values)
## This is not where I did the failed evals -- and I also can't find them!

## impPref += prov

## touch prov_ON.R prov_BC.R ##

$(foreach pref,$(impPref),$(eval $(call impPref_r,$(pref))))

define impPref_r
impmakeR += $(basename `ls prov_*.R`)
endef

impmakeR += `ls prov_*.R`

######################################################################

## Unpredictably does things in the wrong order
Special chaining:

pipeRimplicit += ON
%.ON.Rout: %.rds ON.R
	$(pipeR)

## date_2022-01-01.Rout: date.R
%_date.Rout: date.R
	$(pipeR)

pipeRimplicit += 2022-01-05_date
## 2022-01-05_date.ON.Rout:

######################################################################

## Special chaining that works!

## date_27x.Rout: date.R ; $(pipeR)

date += 27x 27y 27z
define date_r
date_$(1).Rout: date.R ; $$(pipeR)
fakeR += $(1)
endef
$(foreach d, $(date), $(eval $(call date_r,$(d))))
pipeRimplicit += $(date:%=date_%)

## date_27x.Rout: date.R

prov += quc blz rpt
define prov_r
%.prov_$(1).Rout: $(1).R date_%.rds; $$(pipeR)
endef
$(foreach p, $(prov), $(eval $(call prov_r,$(p))))
pipeRimplicit += $(prov:%=prov_%)

## 27z.prov_quc.Rout: quc.R

######################################################################

## Super-chaining

pipeRimplicit += names
## fred.names.Rout: names.R
%.names.Rout: names.R
	$(pipeR)

places = here there elsewhere
recipeChain += places

places_r = %.$(1).places.Rout: $(1).R %.names.rds ; $$(pipeR)

## pipeRimplicit += there.places

## fred.here.places.Rout: here.R

######################################################################

foods = yogurt crumbles

foods_dep = %.places.rda

scriptChain += foods

## pipeRimplicit += crumbles.foods

## fred.here.yogurt.foods.Rout: yogurt.R
## sen.there.crumbles.foods.Rout: crumbles.R

######################################################################

## Gen 2

## 9.xval.Rout:

xy += square
scriptStep += xy
xy_dep = %.xval.rda

# 9.square.xy.Rout: square.xy.R

######################################################################

## docker notes

rdock:
	docker run --rm -ti r-base

######################################################################

## Islands problem (Bicko meta interview)

Sources += islands.tsv
## islands.Rout.tsv: islands.R islands.tsv
islands.Rout: islands.R islands.tsv
	$(pipeR)

######################################################################

## pandoc latex extension what??

Ignore += a_plot.Rout.pdf
Sources += arxiv.sty

Ignore += drop.tex
Sources += drop.rmd
drop.pdf: drop.rmd
	Rscript --vanilla -e 'library("rmarkdown"); render("$<", output_file="$@")'

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
-include makestuff/chains.mk
-include makestuff/pandoc.mk
-include makestuff/texi.mk

-include makestuff/git.mk
-include makestuff/visual.mk
