## This is [project.Makefile] …

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.R)

libs.Rout: libs.R
	$(pipeR)

## matrix exponentiation is not dead easy, so let's try eigen-decomposition for fun
trains.Rout: trains.R
	$(pipeR)

######################################################################

## Messed up efforts to not clone

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

-include makestuff/git.mk
-include makestuff/visual.mk
