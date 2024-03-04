z <- function(c, m, s){
	return((c-m)/s)
}

μ = 8 
σ = 2

print(zbase <- (z(10, μ, σ)))
print(ztop <- (z(11, μ, σ)))

## Prob > 10 is base
print(pbase <- pnorm(-zbase))
print(ptop <- pnorm(ztop))

pbot <- 1-pbase

print((ptop-pbot)/pbase)
