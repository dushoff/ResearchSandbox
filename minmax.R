## I independently invented this as a child, but have seen it many places
## It's half of the harmonic mean
smoothmin <- function(a, b){
	return(a*b/(a+b))
}

## The analog is a bit surprising!
## (1/a + 1/b) / (1/ab) = (a+b)
## Does not approach the max o
smoothmax <- function(a, b){
	return(a+b)
}
