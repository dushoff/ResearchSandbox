set.seed(213)
n <- 1e5
mu <- 1

x <- rexp(n, rate=1/mu)
g <- rgeom(n, prob=1/(mu+1))
mean(x)
mean(g)

xh <- hist(x, freq=FALSE)
hist(g, prob=TRUE)
lines(xh$mids, xh$density)
