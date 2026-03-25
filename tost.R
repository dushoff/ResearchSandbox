n <- 100
slope <- 0
bounds = c(-0.1, 0.1)

impTest <- function(mod, bounds, alpha=0.05){
## test
	sumtab <- coef(summary(mod))["x",]
	est_slope <- sumtab[["Estimate"]]
	slope_se <- sumtab[["Std. Error"]]
	slope_df <- df.residual(mod)

	## one sided test of est_slope < lower_bound
	p1 <- pt((est_slope - min(bounds))/slope_se, df = slope_df,
				lower.tail = FALSE)
	p2 <- pt((max(bounds) - est_slope)/slope_se, df = slope_df,
				lower.tail = FALSE)

	return(pmax(p1, p2))
}

testSim <- function(n, slope, sig, bounds, alpha=0.05, seed=20260325){
	set.seed(seed)
	x <- seq(0, 3, length.out = n)
	y <- rnorm(n, mean = slope*x, sd = sig)
	dd <- data.frame(x, y)

	m <- lm(y ~ x, data = dd)
	print(confint(m, level = 1-2*alpha)["x",])
	print(impTest(m, bounds))
}

testSim(n=n, slope=slope, sig=0.2, bounds=bounds)
testSim(n=n, slope=slope, sig=0.19, bounds=bounds)
