library(shellpipes)
manageConflicts()

library(dplyr)
library(ggplot2); theme_set(theme_bw(base_size=15))
startGraphics()

par <- seq(-4, 4, length.out=201)
ppar <- par[par>=0]

df <- list(
	hazard = data.frame(par=ppar, prob=1-exp(-ppar))
	, logOdds = data.frame(par, prob=plogis(par))
	, logHazard = data.frame(par, prob=1-exp(-exp(par)))
) |> bind_rows(.id="parameter")

summary(df)

plot <-(ggplot(df)
	+ aes(par, prob, color=parameter)
	+ geom_line()
)

print(plot %+% filter(df, parameter=="hazard"))
print(plot %+% filter(df, parameter!="logOdds"))
print(plot %+% filter(df, parameter!="logHazard"))
print(plot)
