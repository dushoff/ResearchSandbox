
## Exogenous cases cause a lot of cases (column 1) but are not caused by cases in our model (row 1)
N <- matrix(
	c(
		0, 0.0, 0.0
		, 1, 0.5, 0.1
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

## Construct the vector for the exogenous distribution of interest
x <- c(1, 0, 0)

## Construct the projection eigenvector and cross-multiply
w <- W[1,]
rel <- t(w) %*% x

## Relative contribution and next-generation contribution of the exogenous case

print(c(relative=rel, ng=rel*R0))

## This is the contribution relative to a “typical” case, and then the contribution to the next generation measured in typical cases. Or something.
