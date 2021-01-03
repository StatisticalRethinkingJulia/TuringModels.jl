+++
title = "Non-identifiable model"
+++

\toc

## Data

```julia:data
y = rand(Normal(0,1), 100);
```

## Model

```julia:model
using Turing

# Can't really set a Uniform[-Inf,Inf] on σ 

@model m8_4(y) = begin
    α₁ ~ Uniform(-3000, 1000)
    α₂ ~ Uniform(-1000, 3000)
    σ ~ truncated(Cauchy(0,1), 0, Inf)

    y .~ Normal(α₁ + α₂, σ)
end

chains = sample(m8_4(y), NUTS(0.65), 2000)
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
         mean      sd     5.5%   94.5% n_eff Rhat
 a1    -861.15 558.17 -1841.89  -31.04     7 1.43
 a2     861.26 558.17    31.31 1842.00     7 1.43
 sigma    0.97   0.07     0.89    1.09     9 1.17
```
