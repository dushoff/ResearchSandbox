## A flow matrix in our sense is an (n+1)×n matrix with columns that sum to zero. We multiply it by the n×1 vector of active states to get net flows for each of the active states plus an outflow.

## We typically wouldn't specify diagonal elements but instead pick them to balance the positive off-diagonal elements specified.

## A chain matrix has flows only along the main sub-diagonal (2, 1) → (n+1, n). The diagonal elements are the negations of these n flows.

chain <- function(v){
	l <- length(v)
	m <- matrix(0
		, nrow=l+1, ncol=l+1
	)
	for (i in 1:l){
		m[[i, i]] = -v[[i]]
		m[[i+1, i]] = v[[i]]
	}
	return(m)
}

## Singular value decomposition!
sdc <- function(m){
	sv <- svd(m)
	return(list(V=sv$u, W=t(sv$v), lam=sv$d))
}

## This probably works really well for this application
## but would be expected to bomb for singular eigenvalues
## Eigenvalue decomposition
edc <- function(m){
	ev <- eigen(m)
	V <- ev$vectors
	W <- solve(V)
	lam <- ev$values
	return(list(V=V, W=W, lam=lam))
}

splitExp <- function(s, t=1){
	D <- diag(exp(s$lam*t))
	return(s$V %*% D %*% s$W)
}

## We are currently reporting the derivative, not the cumulative
## exp(Mt) ⇒ M exp(-Mt)
chainSim <- Vectorize(vectorize="time", function(rates, time){
	size <- length(rates)+1
	m <- chain(rates)
	msplit <- edc(m)
	v0 <- numeric(size)
	v0[[1]] <- 1

	flow <- as.vector(m %*% splitExp(msplit, time) %*% v0)
	return(flow[size])
})

print(chainSim((1:4)/10, 0:100))

