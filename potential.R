cA <- -3.1
xA <- -7.3

cB <- 7.1
xB <- 13.7

## uP <- cA/abs(x-xA) + cB/abs(x-xB)
## =  -cA/(x-xA) - cB/(x-xB)
## ⇒ =  -cA/(x-xA) = cB/(x-xB)
## (cB + cA)x = cAxB + cBxA

## Answer
print(x <- (cA * xB + cB * xA)/(cB + cA))

## Checking
print(uP <- cA/abs(x-xA) + cB/abs(x-xB))
