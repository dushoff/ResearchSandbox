p <- 0.1
n <- 125

standard <- 0.08
pm <- c(-1, 1)/2

pnorm(standard*n+1/2, mean=n*p, sd=sqrt(n*p*(1-p)))

pbinom(standard*n, size=n, p=p)
mean(pbinom(standard*n+pm, size=n, p=p))

n <- 500
p <- 0.44

sqrt(p*(1-p)/n)

