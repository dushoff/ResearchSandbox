n <- 4e5

mbase <- 5
mspread <- 0.5
vbase <- 11

m <- rlnorm(n, meanlog=log(mbase), sdlog=mspread)
v <- rlnorm(n, meanlog=log(vbase))

## gamma algebra
## m=scale*shape
## v=scale^2*shape
## gshape <- m^2/v
## gscale <- m/gshape = v/m

d <- rgamma(n, shape=m^2/v, scale=v/m)

print(mean(m))
print(mean(d))

print(mean(v))
print(var(m))

print(var(d))
