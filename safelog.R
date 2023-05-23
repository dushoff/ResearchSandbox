## x>>s: 1+exp=exp; ̃x=x
## x<<-s log=exp; ̃x=s*exp(x/s)
safelog <- function (x, scale=1){
	return(log(scale*log(1+exp(x/scale))))
}

longlog <- function (x) safelog(x, scale=0.1)

log(2)
safelog(2)
safelog(2, scale=0.01)
safelog(-2)
safelog(-2, scale=0.01)

curve(longlog, from=-2, to=2)
curve(safelog, from=-2, to=2, add=TRUE)
curve(log, from=-2, to=2, add=TRUE)
