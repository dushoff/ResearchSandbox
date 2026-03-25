
set.seed(20260325)

alpha <- 0.05   ## confidence level for 
n <- 100
int <- 0 ## shouldn't matter for now
slope <- 0.97
sd <- 0.3
x <- seq(0, 3, length.out = n)
y <- rnorm(n, mean = int + slope*x, sd = sd)
dd <- data.frame(x, y)
plot(y ~ x, data = dd)

m <- lm(y ~ x, data = dd)
## Lakens says symmetric TOST
##   is equivalent to checking bounds of CI at level (1-2*alpha)
## (90% CI for a TOST at alpha = 0.05)
confint(m, level = 1-2*alpha)["x",]
## this should just fail the equivalence test because the upper bound
## is beyond the bounds we set below

## set equivalence bounds (within 10% of true slope = 1)
bounds <- c(0.9, 1.1)

## test
sumtab <- coef(summary(m))["x",]
est_slope <- sumtab[["Estimate"]]
slope_se <- sumtab[["Std. Error"]]
slope_df <- df.residual(m)

## one sided test of est_slope < lower_bound
p1 <- pt((est_slope - bounds[1])/slope_se, df = slope_df,
         lower.tail = FALSE)
p2 <- pt((bounds[2] - est_slope)/slope_se, df = slope_df,
         lower.tail = FALSE)

## whether we can reject H0 of equivalence
p1 < alpha && p2 < alpha

