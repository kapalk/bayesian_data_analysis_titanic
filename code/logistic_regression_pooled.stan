/**
 * Logistic regression student's t dist prior
 A recommended weakly informative prior

 beta ~ student_t(nu,0,s) where s is chosen to provide weak information on the expected scale, and 3<nu<7.

 Assuming that nonbinary variables have been scaled to have mean 0 and standard deviation 0.5, Gelman et al (2008) (A Weakly
 Informative Default Prior Distribution for Logistic and Other Regression Models) recommended student_t(1,0,2.5) (Cauchy
 distribution). Later it has been observed that this has too thick tails, so that in cases where data is not informative (e.g., in
 case of separation) the sampling from the posterior is challenging (see, e.g., Ghosh et al, 2015,
 http://arxiv.org/abs/1507.07170). Thus Student's t distribution with higher degrees of freedom is recommended. There is not yet
 conclusive results what specific value should be recommended, and thus the current recommendation is to choose 3<nu<7. Normal
 distribution is not recommended as a weakly informative prior, because it is not robust (see, O'Hagan (1979) On outlier rejection
 phenomena in Bayes inference.). Normal distribution would be fine as an informative prior.
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
    for (i in 1:n)
        log_lik[i] = bernoulli_logit_lpmf(y[i] | eta[i]);
}