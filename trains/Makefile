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

## Simulate transmission distributions by exponentiating rate matrices
## matrix exponentiation seems easier to do by hand! (with eigen- decomposition). This is not stable but I don't know how to do it another way
## probably ok for rate matrices specifically
trains.Rout: trains.R
	$(pipeR)

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
