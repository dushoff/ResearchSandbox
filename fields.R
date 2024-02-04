k <- 8.99e9

p <- c(-5, 2-4i, 4i)/100
q <- c(-4.6, 6.2, 3.6)*1e-9

## Divide by |p| once to normalize, and then twice more for r²!
abs(sum(k*q*(p/abs(p)^3)))

3.9e-3*5000

######################################################################

## -4.8e-3
## 3.5e-6kg
## 8 km/s
## -9 kV

m <- 3.0e-6
v0 <- 8e3
q <- -5.9e-3
V <- -9e3

kE0 <- m*v0^2/2
del <- q*V
kE <- kE0 - del

print(kE0)
print(del)

v <- sqrt(2*kE/m)

print(v)

######################################################################

e0 =  8.854e-12
e = 7*e0
r = 3.33/100
d = 0.71/1000
V = 5.1

A = pi*r^2

C = e*A/d

q = C*V

print(q*1e9)
