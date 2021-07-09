# This file was generated, do not modify it. # hide
using Turing

# Thanks to Kai Xu!

@model function m12_2(density, tank, surv)
    σ ~ truncated(Cauchy(0, 1), 0, Inf)
    α ~ Normal(0, 1)

    N_tank = length(tank)
    α_tank ~ filldist(Normal(α, σ), N_tank)

    logitp = α_tank[tank]
    surv .~ BinomialLogit.(density, logitp)
end;