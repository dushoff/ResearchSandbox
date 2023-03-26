
n <- 1e4
mul <- 1
sdl <- 0.66

x <- rlnorm(n, mul, sdl)

print(c(
	obs=mean(x)
	, calc = exp(mul+sdl^2/2)
	, obsCV = sd(x)/mean(x)
))
