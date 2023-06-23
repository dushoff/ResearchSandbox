library(shellpipes)

## Testing simple approaches to propagate error from our estimate of mean serial interval

## Pick parameters from a hyper-distribution and then pick deviates
## lognormal 
lnExperiment <- function(pars, n){
	with(pars, {
		mul <- rnorm(1, 0, mspread)
		sdl <- rgamma(1, shape=sdshape, scale=sdmean/sdshape)
		return(list(dat=rlnorm(n, mul, sdl)
			, mu=exp(mul+sdl^2/2)
			, cv=(exp(sdl^2)-1)*exp(sdl^2)
		))
	})
}

## lognormal 
gamExperiment <- function(pars, n){
	with(pars, {
		mu <- rlnorm(1, 0, mspread)
		shape <- rgamma(1, shape=shapeshape, scale=shapemean/shapeshape)
		return(list(dat=rgamma(n, shape=shape, scale=mu/shape)
			, mu=mu
			, cv=sqrt(1/shape)
		))
	})
}

######################################################################

## Generate posterior on linear scale (rely on clt)
cltPost <- function(dat, psamps){
	sig <- sd(dat)
	mu <- mean(dat)
	n <- length(dat)
	return(rnorm(psamps, mu, sig/sqrt(n)))
}

## Generate posterior means on log scale
## Need to estimate and sample variance down there!
logPost <- function(dat, psamps){
	d <- log(dat)
	sig <- sd(d)
	mu <- mean(d)
	n <- length(d)
	musamp <- rnorm(psamps, mu, sig/sqrt(n))
	sigsamp <- sig*rchisq(psamps, n)/n
	return(exp(musamp+sigsamp^2/2))
}

######################################################################

## This looks like a Bayesian P value to me

p_mu <- function(stat, post){
	return(mean(stat<post))
}

######################################################################

mean_experiment <- function(expFun, postFun, n, psamps, pars){
	x <- expFun(n=n, pars=pars)
	post <- postFun(x[["dat"]], psamps)
	return(p_mu(x[["mu"]], post))
}

## return(t.test(x[["dat"]]-x[["mu"]], alternative="less")[["p.value"]])

######################################################################

mean_ensemble <- function(expFun, postFun, n, psamps, checks, pars){
	replicate(checks
		, mean_experiment(expFun=expFun, postFun=postFun, n=n, psamps=psamps, pars)
	)
}

## replicate(1000, lnExperiment(1, 1, 10))

######################################################################

histFun <- function(expFun, postFun, n, psamps, checks, pars, br=40, name){
	ens <- mean_ensemble(
		expFun=expFun, postFun=postFun
		, n=n, psamps=psamps, checks=checks
		, pars=pars
	)
	return(hist(ens, breaks=(0:br)/br, main=name, xlab="P"))
}

saveEnvironment()
