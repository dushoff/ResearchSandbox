library(ordinal)
library(dplyr)

ngroup <- 4
nrep <- 6
cats <- 5

dat <- expand.grid(
	group = as.factor(1:ngroup)
	, id = 1:nrep
)

dat <- (dat |> mutate(
	result = sample(1:cats, size=nrep*ngroup, replace=TRUE)
	, alt = as.factor((cats+1-result))
	, result = as.factor(result)
))

print(dat)
clmm2(result~1, random=group, data=dat)
clmm2(alt~1, random=group, data=dat)
