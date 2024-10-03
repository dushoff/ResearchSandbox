library(ggplot2)

scale <- 6/pi^2
lim <- 6

curve(plogis(x), from=-lim, to=lim)
curve(pnorm(scale*x), from=-lim, to=lim, add=TRUE)

curve(qlogis(plogis(x)), from=-lim, to=lim)
curve(qlogis(pnorm(scale*x)), from=-lim, to=lim, add=TRUE)

######################################################################

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

print(ggplot(df)
)
