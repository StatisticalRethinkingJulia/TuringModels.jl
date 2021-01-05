+++
title = "StatisticalRethinkingJulia/TuringModels.jl"
tags = ["home", "bayesian statistics"]
reeval = true
+++

This site shows the Julia versions of the Bayesian models described in Statistical Rethinking \citep{pMcElreath2020}.
The models are listed at [Models](models).

We have tried our best to let this site be without mistakes.
However, if you find a mistake on this website, please let us know.
The code for this website is available on [GitHub](https://github.com/StatisticalRethinkingJulia/TuringModels.jl).

### About the pages

Each page aims to contain all the code required to reproduce the results.
In other words, it should be possible to get the same output by just copying the code and the accompanying dataset.
Furthermore, we try to stick to Julia styling conventions where possible.
Therefore, we use unicode symbols in the models.
For example, where the book lists `alpha`, we will use `α` because the Julia language allows that.
As another example, we call DataFrame variables `df`.

### Version

```julia:version
# hideall
println(VERSION)
```

This website is built with Julia \textoutput{version} and

```julia:packages
# hideall
using Pkg

io = IOBuffer()
Pkg.status(; io)
text = String(take!(io))
lines = split(text, '\n')[3:end-1]
lines_without_id = [l[14:end] for l in lines]
list = join(lines_without_id, '\n')
println(list)
```
\output{packages}

### References

\biblabel{pMcElreath2020}{McElreath, 2020}
McElreath, R. (2020). 
Statistical Rethinking: A Bayesian course with examples in R and Stan. 
CRC press.
