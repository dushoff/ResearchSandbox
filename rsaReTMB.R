library(shellpipes)
rpcall("rsaReTMB.Rout rsaReTMB.R rsaRePrep.rds")
library(glmmTMB)

d <- rdsRead()

summary(d)

poism <- glmmTMB(inc ~ group*wave + (1 | date) + offset(log(susc))
	, data = d, family = poisson(link = "log")
)

nbm1 <- update(poism, family=nbinom1)

nbm2 <- update(poism, family=nbinom2)

summary(poism)
summary(nbm1)
summary(nbm2)

saveVars(poism, nbm1, nbm2)

