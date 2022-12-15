# This file was generated, do not modify it. # hide
using StatsFuns: logistic
using Turing

@model function m11_5(admit, applications)
  θ ~ truncated(Exponential(1), 0, Inf)
  α ~ Normal(0, 2)

  # alpha and beta for the BetaBinomial must be provided.
  # The two parameterizations are related by
  # alpha = prob * theta, and beta = (1-prob) * theta.
  # See https://github.com/rmcelreath/rethinking/blob/master/man/dbetabinom.Rd

  prob = logistic(α)
  alpha = prob * θ
  beta = (1 - prob) * θ
  admit .~ BetaBinomial.(applications, alpha, beta)
end

model = m11_5(df.admit, df.applications);