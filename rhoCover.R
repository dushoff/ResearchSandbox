rhoPlot <- function(R){
	rho <- seq(0, 1, by=0.02)
	len <- R/(R+rho-1)
	plot(rho, len, type="p")
	lines(rho, sqrt(1/rho))
}

rhoPlot(1.2)
rhoPlot(2.2)
rhoPlot(3.2)
