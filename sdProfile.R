ll <- function(V){
	return(6-V)
}

curve(ll(x)
	## , from=-1, to=1
	, xlab = "V", ylab="ll"
)

curve(ll(x^2)
	, from=-1, to=1
	, xlab = "sd", ylab="ll"
)
