+++
title = "Gaussian model of height"
reeval = true
+++

\toc

### Model defintion

```julia:height
using DataFrames
using StatsPlots
using Turing
using TuringModels

import CSV

data_path = joinpath(TuringModels.project_root, "data", "Howell1.csv")
df = CSV.read(data_path, DataFrame; delim=';')

# Use only adults and center the weight observations

df2 = filter(row -> row.age >= 18, df)
mean_weight = mean(df2.weight)
df2.weight_c = df2.weight .- mean_weight
first(df2, 5)

@model function line(x, y)
    alpha ~ Normal(178.0, 100.0)
    beta ~ Normal(0.0, 10.0)
    sigma ~ Uniform(0, 50)

    mu = alpha .+ beta*x
    y .~ Normal.(mu, sigma)
end
x = df2.weight_c
y = df2.height
chains = sample(line(x, y), NUTS(0.65), 1000)
```
\output{height}

```julia:write_helper
# hideall
output_dir = @OUTPUT 
function write_svg(name, p) 
  fig_path = joinpath(output_dir, "$name.svg")
  StatsPlots.savefig(fig_path)
end
```
\output{write_helper}

### Output

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

### Original output

```
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
         Mean        SD       Naive SE       MCSE      ESS
alpha 154.597086 0.27326431 0.0043206882 0.0036304132 1000
 beta   0.906380 0.04143488 0.0006551430 0.0006994720 1000
sigma   5.106643 0.19345409 0.0030587777 0.0032035103 1000

Quantiles:
          2.5%       25.0%       50.0%       75.0%       97.5%
alpha 154.0610000 154.4150000 154.5980000 154.7812500 155.1260000
 beta   0.8255494   0.8790695   0.9057435   0.9336445   0.9882981
sigma   4.7524368   4.9683400   5.0994450   5.2353100   5.5090128
```
