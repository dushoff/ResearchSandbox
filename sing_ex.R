library(lme4)
library(tidyverse); theme_set(theme_bw())
set.seed(101)
dd <- data.frame(f = rep(1:3, each = 10),
                 y = rnorm(30))
dd$y <- simulate(~ 1 + (1|f), family = gaussian, newdata = dd,
                 newparams = list(beta = 0, theta = 0.1, sigma = 1))[[1]]

m1 <- lmer(y ~ 1 + (1|f), data = dd)  ## singular fit

pp <- (as.data.frame(profile(m1, signames = FALSE))
	|> filter(.par == "sd_(Intercept)|f")
)

print(pp)

##     select(.zeta, .focal)

par(las = 1, bty = "l")
plot(.zeta ~ .focal, data = pp, type = "b")
