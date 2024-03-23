library(shellpipes)

spot <- csvRead()

print(names(spot))

attach(spot)

summary(as.factor(mode))

major <- sum(spot$mode=="Major")
print(major)
total <- length(spot$mode)

pMajor <- major/total
seMajor <- sqrt(pMajor*(1-pMajor)/total)

z <- (pMajor-0.5)/seMajor
print(1-pnorm(z))

alpha <- 0.1

crit <- c(alpha/2, 1-alpha/2)

ci <- pMajor + qnorm(crit)*seMajor

print(ci)
