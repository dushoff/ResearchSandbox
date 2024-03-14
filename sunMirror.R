
deg <- pi/180
refract <- 1.33
travel <- 45*deg
sun <- 27.6*deg

snell <- asin(refract*sin(travel))

## print(snell/deg)

normal <- mean(c(sun, snell-90*deg))

mirror <- 90*deg+normal

print(mirror/deg)


