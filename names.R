library(shellpipes)

n <- sub("[.].*", "", targetname())
print(n)
rdsSave(n)
