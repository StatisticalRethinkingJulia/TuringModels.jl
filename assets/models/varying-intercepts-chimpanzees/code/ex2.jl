# This file was generated, do not modify it. # hide
using Turing

@model m12_4(pulled_left, actor, condition, prosoc_left) = begin
    # Total num of y
    N = length(pulled_left)

    # Separate σ priors for each actor
    σ_actor ~ truncated(Cauchy(0, 1), 0, Inf)

    # Number of unique actors in the data set
    N_actor = length(unique(actor)) #7

    # Vector of actors (1,..,7) which we'll set priors on
    α_actor ~ filldist(Normal(0, σ_actor), N_actor)

    # Prior for intercept, prosoc_left, and the interaction
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logitp = α .+ α_actor[actor] .+
            (βp .+ βpC * condition) .* prosoc_left

    pulled_left .~ BinomialLogit.(1, logitp)
end;