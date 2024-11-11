
## Consider some formulas
f1 <- y ~ x1 + x2 + s(x3)
f2 <- y ~ x1 + x2 + s
f3 <- y ~ x1 + x2 + foo(7+s(x3))

## our function should recognize f1 (and f3), but not f2, as containing
## a term of the form s(...)

rfun <- function(expr) {
    if (length(expr) == 1) return(FALSE)  ## we've hit bottom
    if (identical(expr[[1]], quote(s))) return(TRUE)
	 for (e in as.list(expr[-1])){
	 	if(rfun(e)) return(TRUE)
	 }
	 return(FALSE)
}

rfun(f1)
rfun(f2)
rfun(f3)

