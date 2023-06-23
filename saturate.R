## Maximum is M
## h is half-sat; defaults to M because this gives s(x)~x for small x
satFun <- function(x, M, h=M){
	return(M*x/(h+x))
}
