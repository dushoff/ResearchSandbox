l <- 400

v <- 1:l

prog <- v+v%/%4-v%/%100+v%/%400

day <- prog%%7

table(day)
