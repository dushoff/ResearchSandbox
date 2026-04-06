
library(dplyr)

set.seed(1545)

gsize <- 4
numPops <- 3
numGroups <- 2 ## not yet implemented
mVal <- 10

dat <- tibble(NULL
	, group = factor(rep(1:numPops, each=gsize))
	, val = rpois(gsize*numPops, mVal)
)
contrasts(dat$group) <- "contr.sum"

print(dat)

print(dat
	|> summarize(m = mean(val), .by=group)
)


m <- (lm(val ~ group, data = dat))
## predict(m)
dat <- (dat
	|> mutate(
		fit = predict(m)
		, resid=val-fit
	)
)

dat <- summarize(dat,
	sP=var(val)
	, sG = var(fit)
	, sI = var(resid)
)
print(dat)

quit()
summary(m)
anova(m)
car::Anova(m)

## Explore residuals and variance


