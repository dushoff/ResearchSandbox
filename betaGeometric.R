library(VGAM)
par(las =1, bty = "l")
x <- 0:16
wb <- dbetageom(x, shape1 = 0.2, shape2 = 0.2)
mb <- dbetageom(x, shape1 = 1, shape2 = 1)
dg <- dgeom(x, prob = 0.5)
matplot(x, cbind(wb, mb, dg), type = "b", pch = 1:2)
