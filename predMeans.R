library(ggplot2); theme_set(theme_bw())
library(lamW)
library(dplyr)

library(shellpipes)

loadEnvironments()

print(T)

## DRY
rogers <- function(N, a, h, T){
	return(N - lambertW0(a*h*N*exp(-a*(T - h*N)))/(a*h))
}

dat <- (data.frame(N, y))

means <- (dat
	|> group_by(N)
	|> summarize(y = mean(y))
	|> ungroup()
	|> mutate(expected=rogers(N, a, h, T))
)

print(means)

print(
	ggplot(means)
	+ aes(x=N)
	+ geom_point(aes(x=N, y=y))
	+ geom_line(aes(x=N, y=expected))
)
