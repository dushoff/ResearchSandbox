library(shellpipes)
library(lme4)

d <- rdsRead()

summary(d)

binm <- glmer(inc/susc ~ group*wave + (1 | date)
	, weights=susc, data = d, family=binomial
)
summary(binm)

warnings()


