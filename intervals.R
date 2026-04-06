
library(HDInterval)
library(dplyr)
library(ggplot2); theme_set(theme_bw())
library(forcats)

obs <- 2

qi <- qgamma(c(0.025, 0.975), shape = obs, rate = obs)

samp <- rgamma(1e5, shape = obs, rate = obs)

rH <- hdi(samp, credMass = 0.95)

tH <- rev(1/hdi(1/samp, credMass = 0.95))

lH <- exp(hdi(log(samp), credMass = 0.95))

res <- (
	tibble(
		method = c("quantile", "rate HPD", "time HPD", "logged HPD"),
		lower = c(qi[1], rH[1], tH[1], lH[1]),
		upper = c(qi[2], rH[2], tH[2], lH[2])
	) |> mutate(method = method |> fct_inorder() |> fct_rev())
)

print(ggplot(res)
	+ aes(y=method, xmin=lower, xmax=upper)
	+ geom_linerange()
	+ scale_x_log10()
)
