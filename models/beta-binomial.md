+++
title = "Beta-binomial"
reeval = true
+++

In Rethinking 2nd Edition, this model is defined as 

$$
\begin{aligned}
  A_i &\sim \text{BetaBinomial}(N_i, \overline{p}_i, \theta) \\
  \text{logit}(\overline{p}_i) &= \alpha_\text{GID}[i] \\
  \alpha_j &\sim \text{Normal}(0, 1.5) \\
  \theta &= \phi + 2 \\
  \phi &\sim \text{Exponential(1)}
\end{aligned}
$$

\toc 

## Data

```julia:data
using DataFrames
using TuringModels # hide

import CSV

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')

@assert size(df) == (12, 5) # hide
write_csv(name, data) = CSV.write(joinpath(@OUTPUT, "$name.csv"), data) # hide
write_csv("data", df) # hide
```
\output{data}

\tableinput{}{./code/output/data.csv}

## Model
```julia:model
using StatsFuns: logistic
using Turing

@model function m11_5(admit, applications)
  θ ~ truncated(Exponential(1), 0, Inf)
  α ~ Normal(0, 2)

  # alpha and beta for the BetaBinomial must be provided.
  # The two parameterizations are related by
  # alpha = prob * theta, and beta = (1-prob) * theta.
  # See https://github.com/rmcelreath/rethinking/blob/master/man/dbetabinom.Rd

  prob = logistic(α)
  alpha = prob * θ
  beta = (1 - prob) * θ
  admit .~ BetaBinomial.(applications, alpha, beta)
end

model = m11_5(df.admit, df.applications)
chains = sample(model, NUTS(0.65), 1000)
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
theta   2.74 0.96  1.43  4.37  3583    1
a       -0.37 0.31 -0.87  0.12  3210    1
```
