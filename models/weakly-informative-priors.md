+++
title = "Weakly informative priors"
+++

This model is a continuation of the [Wild Chain](/models/wild-chain).

\toc

## Data

```julia:data
y = [-1,1]
```

## Model

```julia:model
using Turing

@model function m8_3(y)
    α ~ Normal(1, 10)
    σ ~ truncated(Cauchy(0, 1), 0, Inf)

    μ = α
    y .~ Normal(μ, σ)
end

chains = sample(m8_3(y), NUTS(0.65), 1000);
```
\output{model}

## Output

```julia:write_helper
# hideall
output_dir = @OUTPUT 
function write_svg(name, p) 
  fig_path = joinpath(output_dir, "$name.svg")
  StatsPlots.savefig(fig_path)
end
```
\output{write_helper}

```julia:plot
using StatsPlots

write_svg("chains", # hide
StatsPlots.plot(chains)
) # hide
```
\output{plot}
\fig{chains.svg}

```!
describe(chains)[1] 
```

```!
describe(chains)[2]
```

## Original output

```
      mean   sd  5.5% 94.5% n_eff Rhat
alpha 0.09 1.63 -2.13  2.39   959    1
sigma 2.04 2.05  0.68  4.83  1090    1
```
