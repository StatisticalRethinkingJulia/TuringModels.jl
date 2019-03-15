using TuringModels

@model model() = begin
    a ~ Normal(-10,.1)
    b ~ Normal(-8,.1)
    c ~ Normal(-6,.1)
    d ~ Normal(-4,.1)
    return nothing
end

Nsamples = 2000
Nadapt = 1000
draws = Nadapt+1 : Nsamples
δ = .85
sampler = NUTS(Nsamples, Nadapt, δ)

sampler = Turing.NUTS(2000, 1000, 0.65)
chn = sample(model(), sampler)

chn1 = set_section(chn, Dict(
  :parameters => ["a", "c"],
  :pooled => ["b", "d"],
  :internals => ["elapsed", "epsilon", "eval_num", "lf_eps", "lf_num", "lp"])
)

describe(chn1)
describe(chn1, section=:pooled)
describe(chn1, section=:internals)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

