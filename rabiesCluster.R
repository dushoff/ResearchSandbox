library(dplyr)

numVillages <- 20
medianDogs <- 1000
spread <- 0.4

vaxPropT <- 0.75
vaxPropC <- 0.1
vaxSpread <- 0.1

rProbT <- 0.03
rProbC <- 0.01
rSpread <- 1

## Set up treatment
numTreat <- round(numVillages/2)
treatments <- c(rep("Vax", numTreat), rep("Control", numVillages-numTreat))

latent <- tibble(
	pop = as.integer(rlnorm(numVillages, meanlog=log(medianDogs), sdlog=spread))
	, treat = sample(treatments)
	, vpbase = ifelse(treat=="Vax", vaxPropT, vaxPropC)
	## Beta calculations (follow up with me later)
	, b1 = (1-vpbase)*vaxSpread
	, b2 = vpbase*vaxSpread
	, vp = rbeta(numVillages, 1/b1, 1/b2)

	, vax = rbinom(numVillages, size=pop, prob=vp)
	, unvax = pop-vax

	## Beta calculations for rabies
	, rpBase = ifelse(treat=="Vax", rProbT, rProbC)
	, rps1 = (1-rpBase)*rSpread
	, rps2 = rpBase*rSpread
	, rp = rbeta(numVillages, 1/rps1, 1/rps2)
	, rabies = rbinom(numVillages, size=unvax, prob=rp)
)

## Lot of complications could be added here!!
obs <- (latent
	|> select(treat, vax, unvax, rabies)
)

library(ggplot2); theme_set(theme_minimal())

print(ggplot(obs)
	+ aes(treat, rabies/vax)
	+ geom_boxplot()
)
