
dat <- data.frame(column1=1:3,column2=NA)

v <- c(x=3)

try(v["y"])
try(v[["y"]])

print(dat[, "column2"])
try(dat[, "colum2"])
print(dat[[1, "column2"]])
print(dat[[1, "colum2"]])

