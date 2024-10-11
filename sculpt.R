nSamp <- 1e4
nl <- 31
lmax <- 3

p <- ((1:nSamp)-1/2)/nSamp
lam <- seq(0, lmax, length.out=nl)

cvLam0 <- function(q, lam){
	wt <- exp(-lam*q)
	c0 <- mean(wt)
	c1 <- mean(q*wt)
	c2 <- mean(q*q*wt)
	return(c(
		n = c0
		, m = c1/c0
		, k = c0*c2/c1^2 - 1
	))
}

cvLam <- Vectorize(cvLam0, "lam")

cvPlot <- function(q, lam){
	f <- as.data.frame(t(cvLam(q, lam)))
	return(f)
}

mu <- 2
k <- 0.4
q <- qgamma(p, scale=k*mu, shape=1/k)

cvPlot(
