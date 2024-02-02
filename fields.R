k <- 8.99e9

p <- c(-5, 2-4i, 4i)/100
q <- c(-4.6, 6.2, 3.6)*1e-9

## Divide by |p| once to normalize, and then twice more for r²!
abs(sum(k*q*(p/abs(p)^3)))
