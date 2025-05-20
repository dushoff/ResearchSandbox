library(rbenchmark)

library(rbenchmark)
library(MASS)

randMat <- function(r, c){
	return(matrix(
		runif(r*c), nrow=r
	))
}

massInv <- function(r, c){
	G <- randMat(r, c)
	Gp <- ginv(G)
	return(tcrossprod(Gp))
}

svdInv <- function(r, c){
	G <- randMat(r, c)
	r <- (with(svd(G), {
		v%*%diag(1/d^2)%*%t(v)
	}))
	return(r)
}

crossInv <- function(r, c){
	G <- randMat(r, c)
   Gp <- solve(tcrossprod(G))%*%G
	return(crossprod(Gp))
}

seed <- 2111
r <- 3
c <- 1e3
G <- randMat(r, c)

set.seed(seed); mass=massInv(r, c)
set.seed(seed); svd=svdInv(r, c)
set.seed(seed); cross=crossInv(r, c)
all.equal(mass, svd)
all.equal(mass, cross)

benchmark(replications = 1000
	, massInv(r, c)
	, svdInv(r, c)
	, crossInv(r, c)
)
