## Flows and sims

## A flow matrix in our sense is an (n+1)×n matrix with columns that sum to zero. We multiply it by the n×1 vector of active states to get net flows for each of the active states plus an outflow.

## We typically don't specify diagonal elements but instead pick them to balance the positive off-diagonal elements specified.

## A chain matrix has flows only along the main sub-diagonal (2, 1) → (n+1, n). The diagonal elements are the negations of these n flows. I gave up on trying to use the possibly conceptually helpful (n+1)×n approach because it gets too clunky. We now make an (n+1)×(n+1) square matrix (by appending a column of zeroes for the absorbing state). 

library(Matrix)

library(shellpipes); startGraphics()

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

<<<<<<< HEAD
=======
## matrix exponentiation based on eigenvalue decomposition
## Breaks badly at or near Erlang
## apparently matrix exponentiation is hard; should write ode solver
edcold <- function(m){
	ev <- eigen(m)
	V <- ev$vectors
	W <- solve(V)
	lam <- ev$values
	return(list(V=V, W=W, lam=lam))
}

edc <- function(m){
	ev <- eigen(m)
	V <- ev$vectors
	lam <- ev$values
	W <- t(eigen(t(m))$vectors)
	## return(list(V=V, W=W, lam=lam))
	corr <- solve(W %*% V)
	return(list(V=V, W=corr%*%W, lam=lam))
}

## calculate exp(Mt) for a pre-split matrix M (s is an edc result)
splitExp <- function(s, t=1){
	D <- diag(exp(s$lam*t))
	return(s$V %*% D %*% s$W)
}

>>>>>>> 7039705e66e5271ca9b541ec66af3f21f7776067
## calculate instantaneous flow out of the core of rate matrix M
## as the last element of Mexp(Mt)v0 
chainSimInst <- function(rates, times){
	return(0)
}

chainSim <- function(rates, times){
	size <- length(rates)+1
	m <- chain(rates)

	v0 <- numeric(size)
	v0[[1]] <- 1
	cum <- sapply(c(0, times), function(t){
		return(as.vector(expm(m*t) %*% v0)[size])
	})

	return(diff(cum))
}

## chainSim(1:4, 1:4)
## chainSimInst(1:4, 1:4)
## sum(chainSim(1:4, 1:10))

######################################################################

## Geometric trains

## Make some geometric rates 
## Our convention is rho≤1, and we want the lower rates first for stability
geomRates <- function(boxes, rho=1, base=1){
	return(base*rho^((boxes-1):0))
}

empMean <- function(r){
	return(sum(1/r))
}

empCV <- function(r){
	res <- 1/r
	return(sum(res^2)/sum(res)^2)
}

## The math seemed promising but was horrible, so we calculate the 
## relationship between rho and c purely empirically
cvCheck <- function(rho, c, boxes){
	return(empCV(geomRates(boxes, rho)) - c)
}

cvr <- function(c, boxes, minrat=0.01){
	if(cvCheck(1, c, boxes) > 0) {stop("More boxes needed in cvr")}
	if(cvCheck(minrat, c, boxes) < 0) {stop("CV too high in cvr (reduce minrat if necessary)")}
	return(
		uniroot(cvCheck
			, c(minrat, 1)
			, c, boxes
		)$root
	)
}

v <- c(1, 1, 1, 2)
v <- 1:4
m <- chain(v)

pickRates <- function(m, c, boxes=8){
	rho <- cvr(c, boxes)
	r0 <- geomRates(boxes, rho)
	return(r0*empMean(r0)/m)
}

time <- 1:20
erlangRates <- pickRates(5, 0.3, boxes=4)
erlangSim <- chainSim(erlangRates, time)

trainRates <- pickRates(5, 0.3, boxes=12)
trainSim <- chainSim(trainRates, time)

plot(time, erlangSim, type="b", col="green", log="y")
lines(time, trainSim, type="b", col="blue")

try(pickRates(3, 0.1))
