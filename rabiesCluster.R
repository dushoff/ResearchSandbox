library(dplyr)
library(lme4)

set.seed(23)

rsBeta <- function(n, prob, spread){
	if (spread==0) return(prob)
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
		|> mutate(vill = 1:nrow(latent))
	)

	est <- glmer(rabies/unvax ~ treat + (1|vill), weights=unvax, data=obs, family=binomial())

	## return(summary(est))
	return(exp(confint(est, method="Wald")["treatVax", ]))
}

replicateTrial <- function(reps
	, numVillages, medianDogs, spread 
	, vaxPropT, vaxPropC, vaxSpread 
	, rProbT, rProbC, rSpread 
){
	ints <- replicate(reps, doTrial(numVillages, medianDogs, spread 
		, vaxPropT, vaxPropC, vaxSpread 
		, rProbT, rProbC, rSpread 
	))
	return(ints 
		|> t() |> as.data.frame() |> rename(lwr = `2.5 %`, upr = `97.5 %`)
	)
}

odds <- function(p) return(p/(1-p))
checkTrials <- function(reps
	, numVillages, medianDogs, spread 
	, vaxPropT, vaxPropC, vaxSpread 
	, rProbT, rProbC, rSpread 
){
	or <- odds(rProbT)/odds(rProbC)
	## print(c(or=or))
	return(
		replicateTrial(reps
			, numVillages, medianDogs, spread 
			, vaxPropT, vaxPropC, vaxSpread 
			, rProbT, rProbC, rSpread 
		) |> summarize(
			backwards = mean(lwr>=1)
			, power = mean(upr<=1)
			, low = mean(upr<=or)
			, high = mean(lwr>=or)
		)
	)
}

checkTrials(reps=1000
	, numVillages = 20, medianDogs = 1000, spread = 0.4
	, vaxPropT = 0.75, vaxPropC = 0.1, vaxSpread = 0.1
	, rProbT = 0.01, rProbC = 0.01 , rSpread = 0.4
) 

quit()

doTrial(numVillages = 20
	, medianDogs = 1000, spread = 0.4
	, vaxPropT = 0.75, vaxPropC = 0.1, vaxSpread = 0.1
	, rProbT = 0.01, rProbC = 0.01 , rSpread = 0.4
) 
