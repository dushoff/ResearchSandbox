library(dotwhisker)
library(ggplot2); theme_set(theme_bw(base_size=14))

library(shellpipes)
startGraphics()

set.seed(101)

size <- 100
x <- rnorm(size, mean=4, sd=2)
y <- rnorm(size, mean=4, sd=2)

mod <- lm(y ~ poly(x, 2))
summary(mod)
dwplot(mod)
