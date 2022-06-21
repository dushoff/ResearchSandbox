geomRates <- function(boxes, rho=1, base=1){
	return(base*rho^(0:(boxes-1)))
}

empCV <- function(r){
	res <- 1/r
	return(sum(res^2)/sum(res)^2)
}

## sum(v^2)/sum(v)^2
## Tried the math; even the forward math looks inaesthetic

empCV(geomRates(4, 2))

cvCheck <- function(rho, c, boxes){
	return(empCV(geomRates(boxes, rho)) - c)
}

cvr <- function(c, boxes, minrat=0.01){
	if(cvCheck(1, c, boxes) > 0) {stop("More boxes needed in cvr")}
	if(cvCheck(minrat, c, boxes) < 0) {stop("CV too high in cvr (reduce minrat if necessary)")}
	return(
		uniroot(cvCheck
			, c(minrat, 1)
			, c, boxes
		)$root
	)
}

cvr(0.26, 4)
cvr(0.25, 4)
