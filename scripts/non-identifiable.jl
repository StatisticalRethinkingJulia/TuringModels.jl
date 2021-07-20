# ## Data

using Distributions
using Random

Random.seed!(1)
y = rand(Normal(0,1), 100);

# ## Model

using Turing

@model m8_4(y) = begin
    ## Can't really set a Uniform[-Inf,Inf] on σ 
    α₁ ~ Uniform(-3000, 1000)
    α₂ ~ Uniform(-1000, 3000)
    σ ~ truncated(Cauchy(0,1), 0, Inf)

    y ~ Normal(α₁ + α₂, σ)
end

chns = sample(m8_4(y), NUTS(), 2000)

# ## Output

# \defaultoutput{}

# ## Original output

"""
         mean      sd     5.5%   94.5% n_eff Rhat
 a1    -861.15 558.17 -1841.89  -31.04     7 1.43
 a2     861.26 558.17    31.31 1842.00     7 1.43
 sigma    0.97   0.07     0.89    1.09     9 1.17
""";

