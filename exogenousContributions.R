
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
W <- solve(V)

## Select the left and right dominant eigenvectors
wd <- W[1,]
vd <- V[,1]


## The relative contribution for each class is given by the dominant left eigenvector
## The right eigenvector has been chosen to have L2 norm of 1, and the left eigenvector to multiply it to 1. We scale so that we see contributions relative to the “typical” distribution with a sum of 1.
print(rel <- t(wd) * sum(vd) )

## We define the next-generation contribution as the relative contribution multiplied by R0. For symmetric cases, this should give confirmable answers
print(ng<-rel*R0)
