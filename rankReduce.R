library(rbenchmark)

randMat <- function(seed, r, c){
	set.seed(seed)
	return(matrix(
		runif(r*c), nrow=r
	))
}

size <- function(m){
	return(sum(m^2))
}

idem <- function(u, v){
	return(size(u%*%v%*%u - u))
}

asymm <- function(m){
	return(size(m-t(m)))
}

## Using c>r to match textbook conventions
G <- randMat(seed=3, r=2, c=6)

## A is the bigger matrix
A <- t(G)%*%(G)
B <- (G)%*%t(G)

## Construct a putative inverse generator
H <- t(G)%*%solve(B)

## And a putative pseudo-inverse
HH <- H%*%t(H)

## It may be computationally easier to construct the pseudo-inverse directly?
## Not sure the disadvantages of dropping inverse generator
Ap <- with(svd(G), {
    v%*%diag(1/d^2)%*%t(v)
})

## pseudoinverses are the same
size(Ap-HH)

## pseudoinverses are pseudoinverses
asymm(Ap%*%A)
asymm(A%*%Ap)
idem(A, Ap)
idem(Ap, A)

all.equal(H, MASS::ginv(G))

pinv <- function(G) {
    t(G)%*%solve(tcrossprod(G))
}

all.equal(pinv(G), MASS::ginv(G))

benchmark(pinv(G), MASS::ginv(G), replications = 10000)
## pinv() is a bit faster (45%, might get better with scaling?)
## _and_ uses only matrix operations that (R)TMB probably knows about
## already ...

