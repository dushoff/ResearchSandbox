set.seed(213)

compPlot <- function(mu, nr, nbreaks){
	t <- paste("mean =", mu)
	g <- rgeom(nr, prob=1/(mu+1))
	xm <- max(g)
	cbreaks <- seq(0, xm, length.out=1+nbreaks)
	p <- pexp(cbreaks, rate=1/mu)
	cw <- diff(cbreaks)
	cd <- diff(p)/cw
	cmid <- (cbreaks[-1] +  cbreaks[-length(cbreaks)])/2
	pmid <- (p[-1] +  p[-length(cbreaks)])/2

	## Naive checks
	print(c(
		cnaive=sum((1-pmid)*cw)
		, gnaive=mean(g)
	))

	dbreaks <- seq(-1/2, xm+1/2)
	h <- hist(g, prob=TRUE, breaks = dbreaks, ylim=c(0, max(cd)), main=t)
	lines(cmid, cd)

	## More checks
	## Histogram raw moments
	print(c(
		phih=sum(h$mids^2*h$density)
		, muh=sum(h$mids*h$density)
		, nh=sum(h$density)
	))

	## Density raw moments
	print(c(
		phid=sum(cmid^2*cd*cw)
		, mud=sum(cmid*cd*cw)
		, nd=sum(cd*cw)
	))
}

nr <- 5e4
nbreaks <- 200

compPlot(mu=0.25, nr, nbreaks)
compPlot(mu=0.5, nr, nbreaks)
compPlot(mu=1, nr, nbreaks)
compPlot(mu=2, nr, nbreaks)
compPlot(mu=4, nr, nbreaks)
