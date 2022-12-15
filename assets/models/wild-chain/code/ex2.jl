# This file was generated, do not modify it. # hide
import Random

using Turing

Random.seed!(1)

@model function m8_2(y)
    α ~ Flat() ## improper prior with pobability one everywhere
    σ ~ FlatPos(0.0) ## improper prior with probability one everywhere above 0.0

    y ~ Normal(α, σ)
end;