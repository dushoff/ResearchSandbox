library(shellpipes)
rpcall("rsaReFit.Rout rsaReFit.R rsaRePrep.rds")
library(lme4)

d <- rdsRead()

summary(d)

poism <- glmer(inc ~ group*wave + (1 | date) + offset(log(susc))
	, data = d, family = poisson(link = "log")
)

nbm <- glmer.nb(inc ~ group*wave + (1 | date) + offset(log(susc))
	, data = d
)

summary(nbm)

saveVars(poism, nbm)

