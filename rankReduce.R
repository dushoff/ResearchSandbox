
randMat <- function(seed, r, c){
	set.seed(seed)
	return(matrix(
		runif(r*c), nrow=r
	))
}

## Using c>r currently to match textbook conventions
G <- randMat(3, 2, 6)

## A is the bigger matrix
A <- t(G)%*%(G)
B <- (G)%*%t(G)

attach(svd(G))

## svd of the generator
print(G - (u%*%diag(d)%*%t(v)))

## pseudoinverse of the generator
Gp <- v%*%diag(1/d)%*%t(u)
print(G%*%Gp)

## svd of the big matrix
err <- (A - v%*%diag(d^2)%*%t(v))
print(sum(err^2))

## pseudoinverse of the big matrix
Ap <- v%*%diag(1/d^2)%*%t(v)
print(A%*%Ap)
print(Ap%*%A)
print(Ap%*%A%*%Ap-Ap)
print(A%*%Ap%*%A-A)
