# This file was generated, do not modify it. # hide
@model m12_3(pond, s, ni) = begin
    σ ~ truncated(Cauchy(0, 1), 0, Inf)
    α ~ Normal(0, 1)

    N_ponds = length(pond)

    α_pond ~ filldist(Normal(α, σ), N_ponds)

    logitp = α_pond[pond]
    s .~ BinomialLogit.(ni, logitp)
end;