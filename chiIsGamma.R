n <- 1e5
x <- rnorm(n)
y <- rnorm(n)

z <- (x^2 + y^2)/2

## z <- rexp(n)

for (k in 0:5){
	print(mean(z^k))
}
