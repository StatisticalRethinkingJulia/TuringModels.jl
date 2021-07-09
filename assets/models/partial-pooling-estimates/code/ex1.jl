# This file was generated, do not modify it. # hide
import Random

using DataFrames
using StatsFuns: logistic
using Turing

Random.seed!(1)

μ = 1.4
σ = 1.5
nponds = 60
ni = repeat([5,10,25,35], inner=15)

a_pond = rand(Normal(μ, σ), nponds)

dsim = DataFrame(pond = 1:nponds, ni = ni, true_a = a_pond)

prob = logistic.(dsim.true_a)

dsim.s = [rand(Binomial(ni[i], prob[i])) for i in 1:nponds]

dsim.p_nopool = dsim.s ./ dsim.ni;