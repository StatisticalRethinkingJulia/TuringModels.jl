# This file was generated, do not modify it. # hide
using Turing

@model function globe_toss(n, k)
    θ ~ Beta(1, 1)
    k ~ Binomial(n, θ)
    return k, θ
end;