# This file was generated, do not modify it.

import Random

Random.seed!(1)

n = 9
k = 6;

using Turing

@model function globe_toss(n, k)
    θ ~ Beta(1, 1)
    k ~ Binomial(n, θ)
    return k, θ
end;

using Random

Random.seed!(1)
chns = sample(globe_toss(n, k), NUTS(), 1000)

