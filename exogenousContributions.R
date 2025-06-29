
## Exogenous cases cause a lot of cases (column 1) but are not caused by cases in our model (row 1)
N <- matrix(
	c(
		0, 0.0, 0.0
		, 1, 0.5, 0.5
		, 1, 0.2, 0.5
	) , nrow=3, byrow=TRUE
)

e <- eigen(N)
print(R0 <- e$values[[1]])

## The formal R0 (from this matrix) is the same as the endogenous R0 (ignoring exogenous cases)
print(eigen(N[2:3, 2:3])$values[[1]])

## Make the decomposition
V <- e$vectors

## The left-eigenvector matrix,
## which projects the starting vector onto the relevant space,
## is the inverse of the regular (right) eigenvector matrix
## the R idiom for inverting a matrix is solve
W <- solve(V)

## Select the dominant eigenvectors
wd <- W[1,]
vd <- V[,1]

## The relative contribution for each class is given by wd
## vd has L2 norm of 1, vd·wd=1. 
## Scale so that we see contributions relative to the “typical” distribution with a sum of 1 instead
print(rel <- t(wd) * sum(vd) )

## Define the next-generation contribution as the relative contribution multiplied by R0. 
## We can confirm for example, that if all endogenous cases are symmetric,
## the NG contributions are equal to the naive contributions
## obtained by summing the number of cases caused.
print(ng<-rel*R0)
