
p1 <- 746/1358 
p2 <- 967/1379

pool <- sqrt(p1*(1-p1)/1358 + p2*(1-p2)/1379)
print(pool)
print(pool*qnorm(0.95))

print (p1-p2+pool*qnorm(0.95))
print (p1-p2-pool*qnorm(0.95))

## Sorry for the weird lazy part about 10
d <- c(14, 8, 9, 1, 10, 5, -5, -2)
10* sd(d)/sqrt(length(d))

quit()

70/100 - 70*0.01
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

