
# Here, I simulate an overall species abundance distribution, and then sample
# from it more intensively in the "treatment" ("tx") than in the control ("ct").
# I look at the upper and lower chunk of the overall abundance distribution,
# defining these chunks as comprised of common and rare spp. respectively.

# I want to model two versions of the treatment effect: the relative difference
# in the number of *species* and of *individuals* of each group, i.e., of the
# "rare" spp and the "common" spp, between "tx" and "ct".

# I feel like (since nothing biological is happening that moderates the
# treatment effect by how rare or common species are), I shouldn't see
# differences in how the rare and common groups of spp. respond to the
# treatment. But when I fit negative binomial models to the counts of species
# (and not to the counts of individuals), it looks like there is a **stronger**
# effect for the **rare** spp than the common ones.

# I think this is expected in some sense... for example, the probability that a
# species is not detected is high for rare spp and low for common spp, so it's
# relatively easy to imagine how a rare species is not detected in the control
# but is in the treatment. It's less likely a common species is absent at all.

# but I don't see why this isn't already accounted for in a negative binomial
# glm.

# do you???


# install.packages(MASS)
library(tidyverse)

set.seed(3)


# get 400 regional spp
rich <- 400

# create a species abundance distribution. Details aren't that important here;
# key is that some species are very rare and others very common, going with a
# vaguely realistic distributionn

SAD <- rnbinom(rich*2, size = 0.5, mu = 100) # start with more and drop the
# things that are practically or actually 0.
SAD <- (SAD[order(SAD, decreasing = TRUE)]/sum(SAD))[1:rich]

# plot(SAD)

# create a "treatment" effect. Literally just sampling more individuals from the
# SAD in tx than in control ("ct")
ab_tx <- 300
ab_ct <- 100

# iterate
nrep <- 999

# sample SAD
tx_obs <- rmultinom(nrep, ab_tx, prob = SAD )
ct_obs <- rmultinom(nrep, ab_ct, prob = SAD )

# individuals of common, then rare spp in each tx
common_tx_ab <- apply(tx_obs[1:80,], 2, sum)
common_ct_ab <- apply(ct_obs[1:80,], 2, sum)
rare_tx_ab <- apply(tx_obs[220:300,], 2, sum)
rare_ct_ab <- apply(ct_obs[220:300,], 2, sum)

# number of unique common or rare spp found in teach treatment
pos <- function(x){sum(x>0)}
common_tx_r <- apply(tx_obs[1:80,], 2, pos)
common_ct_r <- apply(ct_obs[1:80,], 2, pos)
rare_tx_r <- apply(tx_obs[220:300,], 2, pos)
rare_ct_r <- apply(ct_obs[220:300,], 2, pos)

# par(mfrow=c(2,1))
# hist(common_tx_ab, xlim = c(0, max(common_tx_ab)*1.1))
# hist(common_ct_ab, xlim = c(0, max(common_tx_ab)*1.1))
#
#
# hist(rare_tx_ab, xlim = c(0, max(rare_tx_ab)*1.1))
# hist(rare_ct_ab, xlim = c(0, max(rare_tx_ab)*1.1))
#
# hist(common_tx_r, xlim = c(0, max(common_tx_r)*1.1))
# hist(common_ct_r, xlim = c(0, max(common_tx_r)*1.1))
#
#
# hist(rare_tx_r, xlim = c(0, max(rare_tx_r)*1.1))
# hist(rare_ct_r, xlim = c(0, max(rare_tx_r)*1.1))

dd <- bind_rows(list("common_tx_r"= common_tx_r
                     , "common_tx_ab"= common_tx_ab
                     , "common_ct_r" = common_ct_r
                     , "common_ct_ab"=common_ct_ab
                     , "rare_tx_r" = rare_tx_r
                     , "rare_tx_ab" = rare_tx_ab
                     , "rare_ct_r" =rare_ct_r
                     , "rare_ct_ab"= rare_ct_ab)) %>%
  pivot_longer(cols = 1:8
               , names_to = c("rarity", "treatment", "response")
               , names_sep = "_")



# Why don't I see the same treatment effect (including same effect size) for
# rare and common species, and why doesn't the negative binomial model account
# for the lower abundance of rare spp?
summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "r" & rarity == "common") ))
summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "r" & rarity == "rare") ))

# Tx effect is stronger for rare spp. It's more likely a rare species will be
# both absent in the control and present in the treatment.


# of course, we expect the same treatment effect for rare and common spp
# when looking only at individuals fromt the two groups (and not
# collapsing them into spp)

summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "ab" & rarity == "common") ))
summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "ab" & rarity == "rare") ))

# not much difference in mean Tx effect. SE obviously still higher for rare spp.

# more like real model
summary(MASS::glm.nb(formula = value~treatment*rarity
                     , data = dd %>% filter(response == "r" )))
summary(MASS::glm.nb(formula = value~treatment*rarity
                     , data = dd %>% filter(response == "ab" )))
