## Out of date!! See email. maybe??

1library(bbmle)
library(nloptr)

def_control <-
    list(algorithm = "NLOPT_LN_BOBYQA", xtol_abs = 1e-08,
         ftol_abs = 1e-08, 
         maxeval = 1e+05)

repl <- function(vals, default) {
    for (n in names(default)) {
        vals[[n]] <- vals[[n]] %||%  default[[n]]
    }
    return(vals)
}

## wrapper function to mimic optim
## modified from lme4::nloptwrap
nloptwrap <- function (par, fn, gr = NULL,
                       method,  ## ignored ... for compatibility with optim
                       ...,
                       lower = -Inf, 
                       upper = Inf, control = list(), hessian = FALSE) {
    if (hessian) stop("hessian not supported")
    control <- repl(control, def_control)
    res <- nloptr(x0 = par, eval_f = fn,
                  eval_grad_f = gr,
                  lb = lower, ub = upper, 
                  opts = control,
                  ...)
    with(res, list(par = solution, value = objective,
                   counts = c(iterations, NA),
                   convergence = if (status < 0 || status == 5) status else 0, 
        message = message))
}

set.seed(101)
dd <- data.frame(z = rpois(100, 2))
dnbinom_kappa <- function(x, mu, kappa, ...) {
    return(dnbinom(x, mu = mu, size = 1/kappa, ...))
}

fit <- mle2(z ~ dnbinom_kappa(exp(logmu), kappa),
            data = dd,
            skip.hessian = TRUE,
            lower = c(logmu = -Inf, kappa = 0),
            upper = c(logmu = Inf, kappa = Inf),
            start = list(logmu = 0, kappa = 1),
            optimizer = "user",
            optimfun = nloptwrap,
            control = list(algorithm = "NLOPT_LN_BOBYQA"))

coef(fit)

## can't use gradient-based methods in nloptr without explicitly
## specifying the gradient function ...

## fit2 <- update(fit, control = list(algorithm = "NLOPT_LD_LBFGS"))

## FIXME/TODO:
# * document 'optimizer = "user"' in mle2 (!)
## * make nloptwrap nicer: set lower/upper if the other is set
##   (nloptr requires both to be set if either is)
## * 'method' -> control$algorithm ?
## * translate method = "BFGS" to NLOPT_LD_LBFGS (closest equivalent),
##   with warning?
## * create an RTMB wrapper for R's dnbinom (more robust)? Not necessarily
##   easy because we don't have a similarly robust implementation of the
##   gradient handy ...


## https://github.com/astamm/nloptr/blob/6d4943aff5a47bd3b3914f86acaa5d6eeeccaa77/R/is.nloptr.R#L65-L79
list_algorithms <- c(
  "NLOPT_GN_DIRECT", "NLOPT_GN_DIRECT_L", "NLOPT_GN_DIRECT_L_RAND",
  "NLOPT_GN_DIRECT_NOSCAL", "NLOPT_GN_DIRECT_L_NOSCAL",
  "NLOPT_GN_DIRECT_L_RAND_NOSCAL", "NLOPT_GN_ORIG_DIRECT",
  "NLOPT_GN_ORIG_DIRECT_L", "NLOPT_GD_STOGO", "NLOPT_GD_STOGO_RAND",
  "NLOPT_LD_SLSQP", "NLOPT_LD_LBFGS_NOCEDAL", "NLOPT_LD_LBFGS",
  "NLOPT_LN_PRAXIS", "NLOPT_LD_VAR1", "NLOPT_LD_VAR2", "NLOPT_LD_TNEWTON",
  "NLOPT_LD_TNEWTON_RESTART", "NLOPT_LD_TNEWTON_PRECOND",
  "NLOPT_LD_TNEWTON_PRECOND_RESTART", "NLOPT_GN_CRS2_LM", "NLOPT_GN_MLSL",
  "NLOPT_GD_MLSL", "NLOPT_GN_MLSL_LDS", "NLOPT_GD_MLSL_LDS", "NLOPT_LD_MMA",
  "NLOPT_LD_CCSAQ", "NLOPT_LN_COBYLA", "NLOPT_LN_NEWUOA",
  "NLOPT_LN_NEWUOA_BOUND", "NLOPT_LN_NELDERMEAD", "NLOPT_LN_SBPLX",
  "NLOPT_LN_AUGLAG", "NLOPT_LD_AUGLAG", "NLOPT_LN_AUGLAG_EQ",
  "NLOPT_LD_AUGLAG_EQ", "NLOPT_LN_BOBYQA", "NLOPT_GN_ISRES", "NLOPT_GN_ESCH"
)
stringr::str_extract(list_algorithms, "(?<=_)[^_]+(?=_)") |> table()

## L = local, G = global,
## N= derivative-free, D = derivative-dependent
