+++
title = "Basic Example"
+++

\toc

## Model definition

We define a simple Normal model with unknown mean and variance.

```julia:model
import CSV

using DataFrames
using StatsPlots
using Turing

@model gdemo(x, y) = begin
  s ~ InverseGamma(2, 3)
  m ~ Normal(0, sqrt(s))
  x ~ Normal(m, sqrt(s))
  y ~ Normal(m, sqrt(s))
end
```

and run the sampler:

```julia:sampler
chains = sample(gdemo(1.5, 2), NUTS(0.65), 1000)
```

## Output

The results are

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
write_svg("height", # hide
StatsPlots.plot(chains)
) # hide
```
\output{plot}
\fig{height.svg}

```!
describe(chains)[1] 
```

```!
describe(chains)[2]
```
