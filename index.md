+++
title = "StatisticalRethinkingJulia/TuringModels.jl"
tags = ["home", "bayesian statistics"]
+++

This site shows the Julia versions of the Bayesian models described in Statistical Rethinking Edition 1 (McElreath, \citet{McElreath2016}) and 2 (McElreath, \citet{McElreath2020}).
The models are listed at [Models](#models).

We have tried our best to let this site be without mistakes.
However, if you find a mistake on this website, please let us know.
The code for this website is available on [GitHub](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

\toc

## Version

```julia:version
# hideall
println(VERSION)
```

This website is built with Julia \textoutput{version} and

```julia:packages
# hideall
import Pkg

deps = [pair.second for pair in Pkg.dependencies()]
deps = filter(p -> p.is_direct_dep, deps)
deps = filter(p -> !isnothing(p.version), deps)
list = ["$(p.name) $(p.version)" for p in deps]
sort!(list)
println(join(list, '\n'))
```
\output{packages}

## Models

The models are listed below.
Each page aims to contain all the code required to reproduce the results.
In other words, it should be possible to get the same output by just copying the code and the accompanying dataset.
Furthermore, we try to stick to Julia styling conventions where possible.
Therefore, we use unicode symbols in the models.
For example, where the book lists `alpha`, we will use `α` because the Julia language allows that.
As another example, we call DataFrame variables `df`, which is also the convention in R and Python.

Before you look at the models below, you might want to look at the [Basic Example](models/basic-example).

### 2nd Edition (2020)

- [globe.qa](models/globe-tossing): Globe tossing
- [m4.1](models/height): Gaussian model of height
- [m8.1](models/africa-first-candidate): Africa first candidate model
- [m12.1](models/beta-binomial): Beta-binomial
- [m13.1](models/varying-intercepts-reedfrogs): Varying intercepts Reedfrogs
- [m13.1](models/varying-slopes-cafe): Varying slopes cafes
- [m13.2](models/multinomial-poisson): Multinomial Poisson regression
- [m13.3](models/varying-intercepts-admission): Varying intercepts admission decisions

### 1st Edition (2016)

- [m2.1](models/globe-tossing): Globe tossing
- [m4.1](models/height): Gaussian model of height
- [m8.1](models/africa): Africa
- [m8.2](models/wild-chain): Wild chain
- [m8.3](models/weakly-informative-priors): Weakly informative priors
- [m8.4](models/non-identifiable): Non-identifiable model
- [m10.3](models/chimpanzees): Chimpanzees
- [m10.4](models/estimate-handedness-chimpanzees): Estimate handedness for each Chimpanzee
- [m10.10](models/oceanic-tool-complexity): Oceanic tool complexity
- [m10.10c](models/oceanic-tool-complexity): Centered Oceanic tool complexity
- [m10.yyt](models/admit-reject): Admit or reject
- [m10.good](models/glimmer): Nonsense estimates for strong associations
- [m11.5](models/beta-binomial): Beta-binomial
- [m11.7](models/multinomial-poisson): Multinomial Poisson regression
- [m12.1](models/varying-intercepts-reedfrogs): Varying intercepts Reedfrogs
- [m12.2](models/multilevel-reedfrogs): Multilevel Reedfrogs
- [m12.3](models/partial-pooling-estimates): Partial-pooling estimates
- [m12.4](models/varying-intercepts-chimpanzees): Varying intercepts Chimpanzees
- [m12.5](models/multi-multilevel-chimpanzees): Multi-multilevel Chimpanzees
- [m12.6](models/over-dispersed-oceanic): Over-dispersed Oceanic
- [m13.4](models/ignoring-gender-admit): Ignoring gender for admittance
- [m13.6](models/multivariate-chimpanzees-priors): Multivariate Chimpanzees priors
- [m13.6nc](models/non-centered-chimpanzees): Non-centered Chimpanzees
- [m13.7](models/spatial-autocorrelation-oceanic): Spatial autocorrelation in Oceanic tools
- [m14.1](models/varying-slopes-cafe): Varying slopes cafes

## References

\biblabel{McElreath2016}{2016}
McElreath, R. (2016).
Statistical Rethinking: A Bayesian Course with Examples in R and Stan. 
CRC press.
<https://doi.org/10.1201/9781315372495>

\biblabel{McElreath2020}{2020}
McElreath, R. (2020). 
Statistical Rethinking: A Bayesian Course with Examples in R and Stan. 
CRC press.
<https://doi.org/10.1201/9780429029608>
