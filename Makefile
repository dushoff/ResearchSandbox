## This is JD's research sandbox

# http://dushoff.github.io/ResearchSandbox/clarStrength.Rout.pdf
# http://dushoff.github.io/ResearchSandbox/digestive.Rout.pdf
# http://dushoff.github.io/ResearchSandbox/pseudoTest.Rout.pdf
# http://dushoff.github.io/sandbox/
## https://github.com/dushoff/ResearchSandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def
-include makestuff/python.def

vim_session: bash -cl "vmt"

######################################################################

## Roswell explorations with BB 

advector.Rout: advector.R

dnbinomX.Rout: dnbinomX.R

## non-Roswell
probit.Rout: probit.R

######################################################################

rtmb.Rout: rtmb.R

######################################################################

rhoCover.Rout: rhoCover.R

## => gradeCalc/

Ignore += rsconnect
gradeCalc.Rout: gradeCalc/app.R 
	$(pipeR)

deploy.Rout: deploy.R

circular.Rout: circular.R

Ignore += rsconnect

##

hist.Rout: hist.R

oranges.Rout: oranges.R

tvalues.Rout: tvalues.R

sunMirror.Rout: sunMirror.R

glassTriangle.Rout: glassTriangle.R

## teacherPlots.R
## spotify.csv

jdPlots.Rout: spotify.csv jdPlots.R
ggMusic.Rout: ggMusic.R spotify.csv
zMusic.Rout: zMusic.R spotify.csv
220.Rout: 220.R
Q3.Rout: Q3.R

focus.Rout: focus.R

## Optics
Sources += focus.md

## Electric charges

potential.Rout: potential.R

tilde:
	ls ~

######################################################################

## clmm testing

ordinal.Rout: ordinal.R

######################################################################

grocery.out: grocery.py
	$(PITH)
## Vectors in R using complex numbers?
## Works OK
complexR.Rout: complexR.R
## Electric fields in R
fields.Rout: fields.R

stats.Rout: stats.R

egf_trim_mre.Rout: egf_trim_mre.R


######################################################################

## macpan2 something

Ignore += quickstart*
quickstart.Rmd:
	wget -O $@ "https://raw.githubusercontent.com/canmod/macpan2/refactorcpp/vignettes/quickstart.Rmd"

## Debugging stan with Mike
stanX.Rout: stanX.R

Example1.Rout: Example1.stan Example1.R

brackets.Rout: brackets.R

## ICI3D labs

iLab1.Rout: iLab1.R

######################################################################

## Make breakpoints

## Put a big .csv file in the pipeline, but only use part of it.

Sources += bigbreak.tsv
breakSelect.Rout: breakSelect.R bigbreak.tsv

## Only if it doesn't exist at all
Ignore += smallbreak.TSV
smallbreak.TSV:
	$(CP) breakSelect.Rout.tsv $@

smallbreak: breakSelect.Rout.tsv smallbreak.TSV
	diff $^ > /dev/null || $(CP) $< smallbreak.TSV

breakCalculate.Rout: breakCalculate.R smallbreak.tsv

## breakCalculate: bigbreak.tsv breakCalculate.Rout
breakCalculate: smallbreak
	$(MAKE) breakCalculate.Rout

######################################################################

## Debugging for Bicko

pngDesc += malaria_time_plots
# malaria_time_plots.cases.png: malaria_time_plots.R descriptives.rda
# malaria_time_plots.props.png: malaria_time_plots.R descriptives.rda
malaria_time_plots.Rout: malaria_time_plots.R descriptives.rda

descriptives.Rout: descriptives.R
	$(wrapR)

pdfDesc += pdfDesc
Ignore += pdfDesc.cases.png
## pdfDesc.cases.png:
## pdfDesc.Rout: pdfDesc.R

######################################################################

## Bayesian sampling and testing

## Check calculations, stats
lnSimp.Rout: lnSimp.R

## Testing pseudo-Bayesian ideas for serial intervals
pseudoFuns.Rout: pseudoFuns.R

## Compare the clt and the log method; log seems better
pseudoComp.Rout: pseudoComp.R pseudoFuns.rda

## Look at some data (don't commit these data from Rowan)
Ignore += testData.csv
testData.Rout: testData.R testData.csv

## Test the good method for realistic gamma or lognormal
pseudoTest.Rout: pseudoTest.R  pseudoFuns.rda

## What do gamma distributions look like?
gamShape.Rout: gamShape.R

######################################################################

## Old version that did trick stuff with Vectorize(get) for no good reason.
clarStrength.Rout: clarStrength.R

## I guess this was something I meant to develop with md talking to pdf...
clarStrength.md: clarStrength.Rout.pdf

## Make a clarStrength-like picture from a table (allow different language)
Sources += $(wildcard *.clarpix.tsv)
## clarity.clarpix.Rout: clarpix.R clarity.clarpix.tsv
## newsig.clarpix.Rout: clarpix.R newsig.clarpix.tsv
## different.clarpix.Rout: clarpix.R different.clarpix.tsv
%.clarpix.Rout: clarpix.R %.clarpix.tsv
	$(pipeR)

## McMaster (Mac) digestive study
## https://pubmed.ncbi.nlm.nih.gov/36731590/
Sources += digestive.tsv digestive.md
digestive.Rout: digestive.R digestive.tsv

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

e313.Rout: e313.R

e313.result:
	R --vanilla < e313.R | grep "\"[A-Z]"

bickoIndex.Rout: bickoIndex.R

######################################################################

## Smooth control functions

safelog.Rout: safelog.R

## Smooth functions to give a large number < min(a, b) or conversely.
minmax.Rout: minmax.R

## Saturating functions
saturate.Rout: saturate.R

######################################################################

## Miriam math

bigsin.Rout: bigsin.R

Sources += $(wildcard *.mac)
Ignore += *.mac.out

derivative.mac.out: derivative.mac
	maxima -b $< > $@

critical.Rout: critical.R

pizza.Rout: pizza.R

squirrel.Rout: squirrel.R

######################################################################

Sources += $(wildcard *.R *.stan)

autopipeR = defined

######################################################################

## Roswell; richness simulations

rrich.Rout: rrich.R
rrsimple.Rout: rrsimple.R

## Messing around on the bus
richtest.Rout: richtest.R

samptest.Rout: samptest.R

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
7.xval.halve.square.square.square.print.Rout:

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

## Toshi handling time 2024 Aug 05 (Mon)

## Experiment code from Toshi
predExperiment.Rout: predExperiment.R

## Test the mean formula; works best when handling time is small
predMeans.Rout: predMeans.R predExperiment.rda

## This looks at _beta_ binomial fitting
predBinom.Rout: predBinom.R predExperiment.rda

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
