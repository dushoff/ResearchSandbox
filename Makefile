## This is JD's research sandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += README.md

######################################################################

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff

## Want to chain and make makestuff if it doesn't exist
## Compress this ¶ to choose default makestuff route
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

## -include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
