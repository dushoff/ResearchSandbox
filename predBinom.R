library(bbmle)
library(emdbook)
library(lamW)

library(shellpipes)

loadEnvironments()

rogers <- function(N, a, h, T){
	return(N - lambertW0(a*h*N*exp(-a*(T - h*N)))/(a*h))
}

nll <- function(N, y, a, h, theta, T){
	expected <- rogers(N, a, h, T)
	return(-sum(dbetabinom(y, size=N
		, shape1 = theta/(1-expected/N), shape2 = theta/(expected/N)
	), log=TRUE))
}

fit <- mle2(nll, start=list(a=1, h=1, theta=1), data=list(y=y, N=N, T=T))

summary(fit)
confint(fit, method="quad")
