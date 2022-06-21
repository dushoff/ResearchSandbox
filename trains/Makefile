## This is [project.Makefile] …

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

autopipeR=defined

Sources += $(wildcard *.R)

libs.Rout: libs.R
	$(pipeR)

## Functions for "trains" (linear chains that are more flexible than the Erlang "boxcars")
trains.Rout: trains.R
	$(pipeR)

## trains.Routput: trains.R

## how do we make geometric series with desired mean and cv?
geometry.Rout: geometry.R

######################################################################

## Messed up efforts to not clone makestuff
## (accidentally cloned on jetpack)

ifdef xEDIT
fluff:
	@echo vedit
else
fluff:
	@echo fluff
endif

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp: | makestuff

makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/pipeR.mk
-include makestuff/compare.mk

-include makestuff/git.mk
-include makestuff/visual.mk
