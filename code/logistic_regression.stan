/**
 * Logistic regression uniform prior
 *
 * Priors:
 *     weights - student t
 *     intercept - student t
 */
data {
    int<lower=0> n;               // number of data points
    int<lower=1> d;               // explanatory variable dimension
    matrix[n, d] X;               // explanatory variable
    int<lower=0,upper=1> y[n];    // response variable
}
parameters {
    real alpha;      // intercept
    vector[d] beta;  // explanatory variable weights
}
transformed parameters {
    // linear predictor
    vector[n] eta;
    eta = alpha + X * beta;
}
model {
    y ~ bernoulli_logit(eta);
}
generated quantities {
    vector[n] log_lik;
    for (i in 1:n)
        log_lik[i] = bernoulli_logit_lpmf(y[i] | eta[i]);
}