
In a perfectly mixed model with differences in mixing rate, the probability you are mixing with an infected individual can be calculated as a ratio of total amounts:

$$ \frac{\sum c_I I_i}{\sum c_I N_I} $$

Or calculated as a weighted average across sub-populations

$$ \frac{\sum{w_i \frac{I_i}{N_I}}}{\sum w_i},$$

where the sub-population weights are $w_i = c_i N_i$. It's easy to say that these turn out the same.

I should rewrite the code to be more clear (and maybe there is still a mistake). If you look at the code, the updated code should have a note about this.
