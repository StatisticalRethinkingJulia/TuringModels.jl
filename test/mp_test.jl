using Distributed
addprocs(4)
@everywhere using TuringModels

@everywhere @model model() = begin
    a ~ Normal(-10,.1)
    b ~ Normal(-8,.1)
    c ~ Normal(-6,.1)
    d ~ Normal(-4,.1)
    return nothing
end


Nsamples = 2000
Nadapt = 1000
draws = Nadapt+1:Nsamples
δ = .85
sampler = NUTS(Nsamples,Nadapt,δ)

chain = combine_chains(pmap(x->sample(model(),sampler),1:4))[draws, :, :]
describe(chain)
