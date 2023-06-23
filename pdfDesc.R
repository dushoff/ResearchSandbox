library(ggplot2)

library(shellpipes)
startGraphics()
loadEnvironments()

dat <- data.frame(x=1:10, y=10:1)

g <- (ggplot(dat)
	+ aes(x, y)
	+ geom_line()
)

saveGG(g, desc="cases")
