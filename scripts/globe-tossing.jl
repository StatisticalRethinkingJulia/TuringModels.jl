# ## Data

n = 9 
k = 6;

# ## Model

using Turing

@model function globe_toss(n, k)
    # Prior.
    θ ~ Beta(1, 1)
    # Model.
    k ~ Binomial(n, θ)
    return k, θ
end;

# ## Output

using Random

Random.seed!(1)
chains = sample(globe_toss(n, k), NUTS(0.65), 1000)

# \defaultoutput{}

