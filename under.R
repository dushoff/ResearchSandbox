
n <- 1000
mean <- 100

p <- 0.4

set.seed(212)

α <- 1.2
ν <- 3

x <- rpois(n, mean)
y <- rpois(n, α*x+ν)
summary(lm(y~x))

xs <- rbinom(n, size=x, prob=p)
ys <- rbinom(n, size=y, prob=p)

summary(lm(ys~xs))

