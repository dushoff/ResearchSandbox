library(tidyverse)

set.seed(3)

# get 400 regional spp
rich <- 400


SAD <- rnbinom(rich*2, size = 0.5, mu = 100) # start with more and drop the
# things that are practically or actually 0.
SAD <- (SAD[order(SAD, decreasing = TRUE)]/sum(SAD))[1:rich]

plot(SAD)

ab_tx <- 300
ab_ct <- 100
nrep <- 999
tx_obs <- rmultinom(nrep, ab_tx, prob = SAD )
ct_obs <- rmultinom(nrep, ab_ct, prob = SAD )
common_tx_ab <- apply(tx_obs[1:80,], 2, sum)
common_ct_ab <- apply(ct_obs[1:80,], 2, sum)
rare_tx_ab <- apply(tx_obs[220:300,], 2, sum)
rare_ct_ab <- apply(ct_obs[220:300,], 2, sum)

pos <- function(x){sum(x>0)}
common_tx_r <- apply(tx_obs[1:80,], 2, pos)
common_ct_r <- apply(ct_obs[1:80,], 2, pos)
rare_tx_r <- apply(tx_obs[220:300,], 2, pos)
rare_ct_r <- apply(ct_obs[220:300,], 2, pos)

par(mfrow=c(2,1))
hist(common_tx_ab, xlim = c(0, max(common_tx_ab)*1.1))
hist(common_ct_ab, xlim = c(0, max(common_tx_ab)*1.1))


hist(rare_tx_ab, xlim = c(0, max(rare_tx_ab)*1.1))
hist(rare_ct_ab, xlim = c(0, max(rare_tx_ab)*1.1))

hist(common_tx_r, xlim = c(0, max(common_tx_r)*1.1))
hist(common_ct_r, xlim = c(0, max(common_tx_r)*1.1))


hist(rare_tx_r, xlim = c(0, max(rare_tx_r)*1.1))
hist(rare_ct_r, xlim = c(0, max(rare_tx_r)*1.1))

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




summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "r" & rarity == "common") ))
summary(MASS::glm.nb(formula = value~treatment
                     , data = dd %>% filter(response == "r" & rarity == "rare") ))

# Tx effect is stronger for rare spp

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
