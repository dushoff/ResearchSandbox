library(RTMB)
sapply(1:3, function(j){
  RTMB::dnbinom_robust(1:50, j, 1, log = TRUE) |> sum() * -1}
)
