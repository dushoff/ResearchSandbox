geomRates <- function(boxes, rho=1, base=1){
	return(base*rho^(0:(boxes-1)))
}

empCV <- function(r){
	res <- 1/r
	return(sum(res^2)/sum(res)^2)
}

## sum/sum^2
## (rho^(2n)-1)/(rho^2-1)) / (rho^(n)-1)/(rho-1))^2 / 
## (ρ-1)(ρ^n+1)/((ρ+1)(ρ^n-1))



dumbCV <- function(b, rho){
	return((rho-1)*(rho^b+1)/(rho+1))
}

empCV(geomRates(4, 2))
dumbCV(4, 2)
