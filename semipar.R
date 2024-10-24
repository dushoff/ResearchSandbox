library(splines)

n <- 100
deg <- 10

v <- 1:n

X <- bs(v, deg)

matplot(v, bs(v, deg), type="l")
matplot(v, ns(v, deg+2), type="l")
