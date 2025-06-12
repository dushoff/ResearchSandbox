## See https://www.wsj.com/market-data/quotes/index/DJIA/historical-prices
DowJonesClosePrice13Jun <- ???

set.seed(100*DowJonesClosePrice13Jun)

people <- sample(c("Seth", "CarL", "Jonathan"))

## The two selected people take these rooms and switch on the Sunday before Week 2
print(c(big=people[[1]], small=people[[2]]))



