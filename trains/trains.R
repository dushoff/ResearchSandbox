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

m <- (chain(1:4))
print(m)

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

chainSim <- function(rates, time){
	m <- chain(rates)
	msplit <- edc(m)
	v0 <- numeric(length(rates)+1)
	v0[[1]] <- 1

	return(m %*% splitExp(msplit, time) %*% v0)
}

chainSim(1:4, 0)
chainSim(1:4, 1)
chainSim(1:4, 2)
chainSim(1:4, 3)

## exp(Mt) ⇒ M exp(-Mt)
