contributions <- function(N){
	e <- eigen(N)
	V <- e$vectors
	W <- solve(V)

	R0 <- e$values[[1]]
	wd <- W[1,]
	vd <- V[,1]

	return(t(wd) * sum(vd) * R0)
}

## When the endogenous cases are symmetric, the next-generation contributions are the same as the naive sums of next-generation contributions, since neither type is more “valuable”
contributions(
	matrix(
		c(
			0, 0.0, 0.0
			, 1, 0.2, 0.6
			, 1, 0.6, 0.2
		) , nrow=3, byrow=TRUE
	)
)

## If one endogenous type is more infectious,
## but we keep cross infection high
## then the more infectious endogenous type should have a lower contribution than the naive estimate
## Not predicting right now what will happen to the exogenous estimate, except maybe it will be a second-order change
contributions(
	matrix(
		c(
			0, 0.0, 0.0
			, 1, 0.4, 0.6
			, 1, 0.6, 0.2
		) , nrow=3, byrow=TRUE
	)
)
## Not really

## If we shift exogenous to infect the more infectious type, we expect
## its contribution to go up
contributions(
	matrix(
		c(
			0, 0.0, 0.0
			, 1.2, 0.4, 0.6
			, 0.8, 0.6, 0.2
		) , nrow=3, byrow=TRUE
	)
)
## but less than I thought. A lot of experiments could be done here.
