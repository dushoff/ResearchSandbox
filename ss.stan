data {
	int<lower=0> N;
	int<lower=0> total[N];
	int<lower=0> positive[N];
	
	real<lower=0> time[N];
	real<lower=0> csd;
	real<lower=0> dsd;

	real<lower=0, upper=1> sensitivity;
	real<lower=0, upper=1> specificity;
}
parameters {
	real delta;
	real center;
}

transformed parameters{
	real<lower=0,upper=1> true[N];
	real<lower=0,upper=1> realized[N];
	for (i in 1:N) {
		true[i] = inv_logit(delta*(time[i]-center));
		realized[i] = true[i] * sensitivity + (1 - true[i]) * (1 - specificity));
	}
}

model{
	delta ~ normal(0, dsd);
	center ~ normal(0, csd);
	for (i in 1:N) {
		positive[i] ~ binomial(total[i], realized[i]);
	}
}

