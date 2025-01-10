set.seed(213)
n <- 1e4
mu <- 1

x <- rexp(n, rate=1/mu)
g <- rgeom(n, prob=1/(mu+1))
mean(x)
mean(g)

hist(x, freq=FALSE)
hist(g, prob=TRUE)
