expected <- c(3, 7, 9)

print(sum(expected))

## pop <- [[Try 20 or 1e6]]
pop <- 2e6

haz <- function(x) -log(1-x)
unhaz <- function(x) 1-exp(-x)

h <- haz(expected/pop)
print(h)
print(pop*unhaz(sum(h)))
