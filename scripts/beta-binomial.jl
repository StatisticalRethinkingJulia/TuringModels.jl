
# ## Data

import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')

# ## Model

using StatsFuns: logistic
using Turing

@model function m11_5(admit, applications)
  θ ~ truncated(Exponential(1), 0, Inf)
  α ~ Normal(0, 2)

  ## alpha and beta for the BetaBinomial must be provided.
  ## The two parameterizations are related by
  ## alpha = prob * theta, and beta = (1-prob) * theta.
  ## See https://github.com/rmcelreath/rethinking/blob/master/man/dbetabinom.Rd

  prob = logistic(α)
  alpha = prob * θ
  beta = (1 - prob) * θ
  admit .~ BetaBinomial.(applications, alpha, beta)
end

model = m11_5(df.admit, df.applications);

# ## Output

chns = sample(model, NUTS(), 1000)

# \defaultoutput{}

# ## Original output

"""
        mean   sd  5.5% 94.5% n_eff Rhat
theta   2.74 0.96  1.43  4.37  3583    1
a       -0.37 0.31 -0.87  0.12  3210    1
""";
