+++
title = "Globe tossing"
+++

\toc 

## Data

```julia:data
k = 6
n = 9
```

## Model

```julia:model
using DataFrames
using Turing

@model function globe_toss(n, k)
  θ ~ Beta(1, 1) # prior
  k ~ Binomial(n, θ) # model
  return k, θ
end

chains = sample(globe_toss(n, k), NUTS(0.65), 1000)
```
\output{model}

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

# Show the hpd region
hpd(chns, alpha=0.055) |> display
