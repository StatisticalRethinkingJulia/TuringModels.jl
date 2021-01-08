# ## Data

y = [-1,1]

# ## Model

using Turing

@model function m8_3(y)
    α ~ Normal(1, 10)
    σ ~ truncated(Cauchy(0, 1), 0, Inf)

    μ = α
    y .~ Normal(μ, σ)
end;

# ## Output

chains = sample(m8_3(y), NUTS(0.65), 1000)

# \defaultoutput{}

# ## Original output

"""
      mean   sd  5.5% 94.5% n_eff Rhat
alpha 0.09 1.63 -2.13  2.39   959    1
sigma 2.04 2.05  0.68  4.83  1090    1
""";
