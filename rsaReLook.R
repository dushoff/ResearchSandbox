library(shellpipes)
rpcall("rsaReLook.Rout rsaReLook.R rsaRe.rda")
library(ggplot2); theme_set(theme_bw(base_size=12))

loadEnvironments()
startGraphics(height=4, width=8)

names(gdata)

print(ggplot(gdata)
	+ aes(date, value, color=class)
	+ scale_y_continuous(trans = "log1p")
	+ geom_line(aes(group=interaction(class, wave)))
	+ facet_grid(cols=vars(group))
)
