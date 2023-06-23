library(shellpipes)
loadEnvironments()
startGraphics()

n <-20
psamps <- 800
checks <- 5000
lnpars <- list(mspread=2, sdshape=10, sdmean=0.66)
gampars <- list(mspread=2, shapeshape=10, shapemean=2)

print(histFun(lnExperiment, logPost, n, psamps, checks
	, name="lognormal"
	, pars=lnpars
))

print(histFun(gamExperiment, logPost, n, psamps, checks
	, name="gamma"
	, pars=gampars
))
