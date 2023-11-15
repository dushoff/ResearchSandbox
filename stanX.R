
library(rstan)

rstan_options(auto_write = TRUE)

modelcode <- "
data {
}

transformed data {
}

parameters {   
real<lower=3.3,upper=3.5>   mu; 
}

model {
	target += 1/(mu-3.3);
	//print(mu);
}
"

fit <- stan(model_code=modelcode, data=list(), iter=1000, thin=10, chains=1)
print(fit)
