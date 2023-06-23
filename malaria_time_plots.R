library(ggplot2)

library(shellpipes)
startGraphics()
loadEnvironments()

g <- (ggplot(dat)
	+ aes(x, y)
	+ geom_line()
)

saveGG(g, ext="png", desc="cases")
