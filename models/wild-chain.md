+++
title = "Wild chain"
+++

This model shows what happens if you use extremely flat priors, and is fixed in [Weakly Informative Priors](/models/weakly-informative-priors).

\toc

## Data 

```julia:data
y = [-1, 1]
```

## Model
```julia:model
using Turing

@model m8_2(y) = begin
    σ ~ FlatPos(0.0) # improper prior with probability one everywhere above 0.0
    α ~ Flat() # improper prior with pobability one everywhere

    y .~ Normal(α, σ)
end

chains = sample(m8_2(y), NUTS(0.65), 1000)
```

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
