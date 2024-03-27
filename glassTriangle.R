deg <- pi/180

upper_out <- 45*deg
refract <- 1.4

upper_in <- asin(sin(upper_out)/refract)

lower_out <- 45*deg-upper_in
lower_in <- asin(sin(lower_out)*refract)

print(lower_in/deg)

