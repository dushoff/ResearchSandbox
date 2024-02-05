z <- function(c, m, s){
	return((c-m)/s)
}

μ = 162
σ = 28

ztop <- (z(138, μ, σ))
print(ztop)
print(pnorm(ztop))

zbot <- (z(105, μ, σ))
print(zbot)
print(pnorm(zbot))

print(pnorm(ztop) - pnorm(zbot))
