## 1/f = 1/o + 1/i
## Near-sighted people use concave lenses

cm <- 1/100

book <- 28
near <- 55 
space <- 1.2

str <- 1/(book-space) - 1/(near-space)
print(1/str)

quit()
r <- 2.1
f <- r/2
o <- 4.7
h <- 39.7*cm

i <- 1/(1/f - 1/o)

print(i)
print(o*h/i)

book <- 23.6
glass <- 1.69
near <- 70.9

1/near - 1/(book-glass)
