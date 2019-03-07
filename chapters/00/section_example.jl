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

chn1 = move_parameters_to_new_section(chn, :pooled, ["b", "d", "zeta"])

describe(chn1)
describe(chn1, section=:pooled)

mean(chn1[:a])

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

