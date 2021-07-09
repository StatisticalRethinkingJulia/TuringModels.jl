# This file was generated, do not modify it. # hide
using Turing
using StatsFuns: logistic

@model function reedfrogs(Nᵢ, i, Sᵢ)
    αₜₐₙₖ ~ filldist(Normal(0, 1.5), length(i))
    pᵢ = logistic.(αₜₐₙₖ[i])
    Sᵢ .~ Binomial.(Nᵢ, pᵢ)
end;