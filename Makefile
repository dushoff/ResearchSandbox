## This is JD's research sandbox

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += README.md

resources/%: resources
resources:
	$(resDrop)

######################################################################

Sources += $(wildcard *.R)

autopipeRcall = defined

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

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

## Want to chain and make makestuff if it doesn't exist
## Compress this ¶ to choose default makestuff route
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
