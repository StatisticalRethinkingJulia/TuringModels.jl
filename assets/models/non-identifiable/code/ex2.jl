# This file was generated, do not modify it. # hide
using Turing

@model function m8_4(y)
    # Can't really set a Uniform[-Inf,Inf] on σ
    α₁ ~ Uniform(-3000, 1000)
    α₂ ~ Uniform(-1000, 3000)
    σ ~ truncated(Cauchy(0,1), 0, Inf)

    y ~ Normal(α₁ + α₂, σ)
end

chns = sample(m8_4(y), NUTS(), 2000)