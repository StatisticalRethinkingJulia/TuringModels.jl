# This file was generated, do not modify it. # hide
using Turing

@model function m_good_stan(x, y)
    α ~ Normal(0, 10)
    β ~ Normal(0, 10)

    logits = α .+ β * x

    y .~ BinomialLogit.(1, logits)
end;