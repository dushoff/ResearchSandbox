library(dplyr)

rsBeta <- function(n, prob, spread){
	if (spread==0) return(rep(prob, n))
	b1 = (1-prob)*spread
	b2 = prob*spread
	return(rbeta(n, 1/b1, 1/b2))
}

doTrial <- function(
	numVillages, medianDogs, spread 
	, vaxPropT, vaxPropC, vaxSpread 
	, rProbT, rProbC, rSpread 
){
	## Set up treatment
	numTreat <- round(numVillages/2)
	treatments <- c(rep("Vax", numTreat), rep("Control", numVillages-numTreat))

	latent <- tibble(
		pop = as.integer(rlnorm(numVillages
			, meanlog=log(medianDogs), sdlog=spread)
		)
		, treat = sample(treatments)
		, vpbase = ifelse(treat=="Vax", vaxPropT, vaxPropC)

		## Beta calculations (follow up with me later)
		, vp = rsBeta(numVillages, vpbase, vaxSpread)
		, vax = rbinom(numVillages, size=pop, prob=vp)
		, unvax = pop-vax

		## Beta calculations for rabies
		, rpBase = ifelse(treat=="Vax", rProbT, rProbC)
		, rp = rsBeta(numVillages, rpBase, rSpread)
		, rabies = rbinom(numVillages, size=unvax, prob=rp)
	)

	## Lot of complications could be added here!!
	obs <- (latent
		|> select(treat, vax, unvax, rabies)
	)

	est <- glm(rabies/unvax ~ treat, weights=unvax, data=obs, family=binomial())

	return(exp(confint(est)["treatVax", ]))
}

print(doTrial(
	numVillages = 20, medianDogs = 1000, spread = 0.4
	, vaxPropT = 0.75, vaxPropC = 0.1, vaxSpread = 0.1
	, rProbT = 0.01, rProbC = 0.05 , rSpread = 1
))
