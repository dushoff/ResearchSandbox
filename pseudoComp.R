
library(shellpipes)
loadEnvironments()

histComp <- function(pars, n=20, psamps=1000, checks=5000, br=40){
	par(mfrow=c(2, 1))
	print(histFun("log method", postFun=logPost
		, expFun=lnExperiment
		, pars=pars
		, n=n
		, psamps=psamps, checks=checks, br=br
	))
	print(histFun("linear method", postFun=cltPost
		, expFun=lnExperiment
		, pars=pars
		, n=n
		, psamps=psamps, checks=checks, br=br
	))
}

histComp(pars=list(mspread=2, sdshape=4, sdmean=0.1))
histComp(pars=list(mspread=4, sdshape=2, sdmean=1))
histComp(n=1000, pars=list(mspread=4, sdshape=2, sdmean=1))

