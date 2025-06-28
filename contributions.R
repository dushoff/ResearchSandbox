contributions <- function(N){
	e <- eigen(N)
	V <- e$vectors
	W <- solve(V)

	R0 <- e$values[[1]]
	wd <- W[1,]
	vd <- V[,1]

	return(t(wd) * sum(vd) * R0)
}

contributions(
	matrix(
		c(
			0, 0.0, 0.0
			, 1, 0.5, 0.6
			, 1, 0.6, 0.5
		) , nrow=3, byrow=TRUE
	)
)

