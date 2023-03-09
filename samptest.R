
## Code from ChatGPT after several collaborative iterations.

# create a vector of values
values <- as.factor(6:9)

sampled_values <- sample(values, 6, replace = TRUE)

print(sampled_values)

# tabulate the occurrences of each value in the sample
result_vector <- tabulate(sampled_values, nbins = length(values))

# display the result vector
result_vector
