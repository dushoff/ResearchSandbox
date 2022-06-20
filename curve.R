library(logitnorm)

tcurve <- function(x, offset=1){
	s <- qlogis(x)
	return(plogis(s+offset))
}

score <- seq(0, 1, by = 0.01)

plot(score, tcurve(score))
points(score, tcurve(score), col="blue")
