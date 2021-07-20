# ## Data 

y = [-1, 1]

# ## Model

import Random

using Turing

Random.seed!(1)

@model function m8_2(y)
    α ~ Flat() ## improper prior with pobability one everywhere
    σ ~ FlatPos(0.0) ## improper prior with probability one everywhere above 0.0

    y ~ Normal(α, σ)
end;

# ## Output

chns = sample(m8_2(y), NUTS(), 1000)

# \defaultoutput{}

