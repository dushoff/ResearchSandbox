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

## m formula
## I'm using the absolute value of both charges
## Then I take the value from the formula and treat it as distance from the smaller charge

d <- xB - xA
bal <- -cA*d/(cB+cA)
print(x <- xA - bal)

## x formula (the between from Miriam's sheet)
bal <- -cA*d/(cB-cA)
print(bal)
print(x <- xA + bal)

print(uP <- cA/abs(x-xA) + cB/abs(x-xB))
