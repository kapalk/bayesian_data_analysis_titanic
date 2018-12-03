/**
 * Logistic regression with student's t prior
 */
data {
    int<lower=0> n;               // number of data points
    int<lower=1> d;               // explanatory variable dimension
    matrix[n, d] X;               // explanatory variable
    int<lower=0,upper=1> y[n];    // response variable
    
    int<lower=1> p_beta_df;       // prior degrees of freedom for beta
    real<lower=0> p_beta_scale;   // prior scale for beta
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
    beta ~ student_t(p_beta_df, 0, p_beta_scale);
    y ~ bernoulli_logit(eta);
}
generated quantities {
    vector[n] log_lik;
    real p_hat_ppc = 0;

    for (j in 1:n) {
        int y_ppc = bernoulli_logit_rng(eta[j]);
        p_hat_ppc = p_hat_ppc + y_ppc;
    }
    p_hat_ppc = p_hat_ppc / n;
        
    for (i in 1:n)
        log_lik[i] = bernoulli_logit_lpmf(y[i] | eta[i]);
}