library(shellpipes)


si <- csvRead()$x
## si <- log(si)

m <- mean(si)
s <- sd(si)
M3 <- mean((si-mean(si))^3)
k <- M3/s^3
cv <- m/s

print(c(m=m
	, cv=cv
	, k=k
))
