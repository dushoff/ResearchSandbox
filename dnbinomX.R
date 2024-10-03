library(RTMB)

dnbinom_robust(3, log(3), log(1e-9), log = TRUE)
dnbinom_robust(3, log(3), log(1e-11), log = TRUE)
dnbinom_robust(3, log(3), log(1e-12), log = TRUE) # best
dnbinom_robust(3, log(3), log(1e-13), log = TRUE) # larger NLL
dnbinom_robust(3, log(3), log(1e-14), log = TRUE) # wtf?

dnbinom2(3, 3, 3+1e-9, log = TRUE)
dnbinom2(3, 3, 3+1e-11, log = TRUE)
dnbinom2(3, 3, 3+1e-12, log = TRUE) # best
dnbinom2(3, 3, 3+1e-13, log = TRUE) # larger NLL
dnbinom2(3, 3, 3+1e-14, log = TRUE) # wtf?
dnbinom2(3, 3, 3, log = TRUE) # NaN

quit()

## https://github.com/kaskr/adcomp/blob/1130f2efb488a708834e4bf618a4e1a4a208ae9c/TMB/inst/include/tiny_ad/robust/distributions.hpp#L47 

inline Float dnbinom_robust(const Float &x,
                              const Float &log_mu,
                              const Float &log_var_minus_mu,
                              int give_log = 0) {
    // Float p = mu / var;
    // Float n = mu * p / (1. - p);
    Float log_var = logspace_add( log_mu, log_var_minus_mu );
    Float log_p   =     log_mu - log_var;
    Float log_n   = 2 * log_mu - log_var_minus_mu;
    Float n = exp(log_n);  // NB: exp(log_n) could over/underflow
    Float logres = n * log_p;
    if (x != 0) {
      Float log_1mp = log_var_minus_mu - log_var;
      logres += lgamma(x + n) - lgamma(n) - lgamma(x + 1.) + x * log_1mp;
    }
    return ( give_log ? logres : exp(logres) );
  }
