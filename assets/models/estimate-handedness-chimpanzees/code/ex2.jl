# This file was generated, do not modify it. # hide
using Turing

@model m10_4(y, actors, x₁, x₂) = begin
    # Number of unique actors in the data set
    N_actor = length(unique(actors))

    # Set an TArray for the priors/param
    α ~ filldist(Normal(0, 10), N_actor)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logits = α[actors] .+ (βp .+ βpC * x₁) .* x₂
    y .~ BinomialLogit.(1, logits)
end

model = m10_4(df.pulled_left, df.actor, df.condition, df.prosoc_left);