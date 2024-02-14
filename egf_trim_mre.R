library(epigrowthfit)

dat <- data.frame(
	time = c(1:5, 0)
	, inc = c(2, 3, 5, 8, 13, NA)
)

fakewin <- data.frame(start = -Inf, end=Inf)

mod <- egf(model = egf_model(curve = "logistic", family = "nbinom")
	, data_ts = dat
	, formula_ts = cbind(time, inc) ~ 1
	, formula_parameters = ~ 1
	, data_windows = fakewin
	, formula_windows = cbind(start, end) ~ 1
	, se = TRUE
) 

print(mod)
plot(mod)
