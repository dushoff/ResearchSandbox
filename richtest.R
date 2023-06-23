library(dplyr)
library(tidyr)

set.seed(3)

regionalRichness <- 400
sdlogAbund = 0.4
bigSamp <- 300
smallSamp <- 100
numBig <- numSmall <- 10

samplePlot <- function(sampleSize, species){
	inds <- rmultinom(sampleSize, species$id, prob = species$relAbund)
}

SAD <- (
	rlnorm(regionalRichness, sdlog=sdlogAbund)
	%>% sort(decreasing = TRUE)
)

spProfile <- data.frame(id = factor(1:regionalRichness)
	, relAbund = SAD <- SAD/sum(SAD)
)

dat <- (
	data.frame(treatment = c(rep("big", numBig), rep("small", numSmall)))
	%>% mutate(sample = ifelse(treatment=="big", bigSamp, smallSamp))
)

summary(dat %>% mutate_if(is.character, as.factor))

# plot(SAD)

quit()

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
