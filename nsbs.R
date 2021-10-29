library(dplyr)
library(tidyr)
library(ggplot2)

library(splines)
library(shellpipes)

set.seed(101)

n <- 100
reps <- 100
d <- 3

twosims <- function(n){
	return(
		tibble(NULL
			, x = runif(n)
			, y = rnorm(n)
		) %>% mutate(
			, bs = predict(lm(y~bs(x, d)))
			, ns = predict(lm(y~ns(x, d)))
		) %>% pivot_longer(cols=c(bs, ns), names_to="type", values_to="pred")
	)
}

twoplots <- function(n){
	print(ggplot(twosims(n))
		+ aes(x=x, y=pred, color=type)
	)
}

twoplots(n)
