library(shellpipes)
rpcall("rsaReFitLook.Rout rsaReFitLook.R rsaReFit.rda")
library(DHARMa)

loadEnvironments()

plot(simulateResiduals(poism))
