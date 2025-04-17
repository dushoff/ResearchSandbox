
randMat <- function(seed, r, c){
	set.seed(seed)
	return(matrix(
		runif(r*c), nrow=r
	))
}

size <- function(m){
	return(sum(m^2))
}

mapTest <- function(u, v){
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

## Construct an inverse generator
H <- t(G)%*%solve(B)

## And a pseudo-inverse
HH <- H%*%t(H)

## It is also possible to construct the pseudo-inverse directly from the svd of the generator.
## Not sure the what the advantages of each approach are
attach(svd(G))
Ap <- v%*%diag(1/d^2)%*%t(v)

## pseudoinverses are the same
size(Ap-HH)

## pseudoinverses are pseudoinverses (two symmetry conditions, two mapping conditions)
asymm(Ap%*%A)
asymm(A%*%Ap)
mapTest(A, Ap)
mapTest(Ap, A)

