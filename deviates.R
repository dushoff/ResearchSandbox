set.seed(213)
n <- 1e5
mu <- 0.4

x <- rexp(n, rate=1/mu)
g <- rgeom(n, prob=1/(mu+1))
mean(x)
mean(g)

compPlot <- function(disc, cts, cpoints){
	xm <- max(disc)
	dbreaks <- seq(-1/2, xm+1/2)
	cbreaks <- seq(-1/2, xm+1/2, by=1/cpoints)
	ch <- hist(x, breaks=cbreaks, plot=FALSE)
	dmax <- max(ch$density)
	hist(g, prob=TRUE, breaks = dbreaks, ylim=c(0, dmax))
	pos <- ch$density>0
	lines(ch$mids[pos], ch$density[pos], type="b")
}

compPlot(g, x, 4)
