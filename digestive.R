library(ggplot2); theme_set(theme_bw(base_size=14))
library(dplyr)

library(shellpipes)
startGraphics(height=8)

cutoff <- 1.25

df <- tsvRead()

print(ggplot(df)
	+ aes(Diet, HR)
	+ geom_point()
	+ geom_errorbar(aes(ymin=lwr, ymax=upr), width=0.1)
	+ coord_flip()
	+ geom_hline(yintercept=1)
	+ geom_hline(yintercept=c(1/cutoff, cutoff), lty=2)
	+ scale_y_log10()
	+ facet_wrap(~Disorder, ncol=1)
)

