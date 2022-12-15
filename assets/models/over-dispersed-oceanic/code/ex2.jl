# This file was generated, do not modify it. # hide
using Turing

@model function m12_6(total_tools, log_pop, society)
    N = length(total_tools)

    α ~ Normal(0, 10)
    βp ~ Normal(0, 1)

    σ_society ~ truncated(Cauchy(0, 1), 0, Inf)

    N_society = length(unique(society)) ## 10

    α_society ~ filldist(Normal(0, σ_society), N_society)

    for i in 1:N
        λ = exp(α + α_society[society[i]] + βp*log_pop[i])
        total_tools[i] ~ Poisson(λ)
    end
end;