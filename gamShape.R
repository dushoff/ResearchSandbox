x <- seq(0.05, 0.25, length.out=100)
d <- dgamma(x, shape=51, rate=301.81)

plot(x, d)
