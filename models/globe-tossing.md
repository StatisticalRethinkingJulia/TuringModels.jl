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

## Output

\defaultoutput{}

# Show the hpd region
hpd(chns, alpha=0.055) |> display
