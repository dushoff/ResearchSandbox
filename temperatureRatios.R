C <- seq(-40, 160, length.out=1001)
F <- 9/5*C + 32
ratio <- C/F
plot(
	F, ratio
	, xlim=c(-10, 110)
	, log="y", ylim=c(0.1, 10)
	, type = "l"
)


