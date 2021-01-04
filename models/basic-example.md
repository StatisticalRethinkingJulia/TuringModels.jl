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

\defaultoutput{}
