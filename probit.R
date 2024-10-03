library(ggplot2); theme_set(theme_bw())

scale <- 6/pi^2
lim <- log(99)
steps <- 201

x <- seq(-lim, lim, length.out=steps)
logit <- plogis(x)
probit <- pnorm(scale*x)

df <- data.frame(
	x = c(x, x)
	, p = c(logit, probit)
	, dist = rep(c("logit", "probit"), each=steps)
)

base <- (ggplot(df)
	+ aes(x, p, color=dist)
	+ geom_line()
)

print(base)

b <- c(0.005, 0.01, 0.02, 0.05, 0.1, 0.2)
bb <- c(b, 0.5, 1-b)

print(base + scale_y_continuous(trans="logit" , breaks=bb, minor_breaks=NULL))
