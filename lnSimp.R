
n <- 1e4
mul <- 3
sdl <- 0.5

x <- rlnorm(n, mul, sdl)

print(c(
	obs=mean(x)
	, calc = exp(mul+sdl^2/2)
))
