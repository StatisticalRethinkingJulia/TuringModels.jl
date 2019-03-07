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

chn1 = chn[draws, :, :]

show(chn1) 

chn2 = move_parameters_to_new_section(chn1, :pooled, ["b", "d"])

describe(chn2) |> display
describe(chn2, section=:pooled) |> display
