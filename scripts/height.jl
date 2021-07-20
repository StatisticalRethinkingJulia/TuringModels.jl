# ## Data

import CSV

using DataFrames
using Random
using Turing
using TuringModels

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "Howell1.csv")
df = CSV.read(data_path, DataFrame; delim=';')
df = filter(row -> row.age >= 18, df);

# For df, see Section [df](#df).

# ## Model

@model function line(height)
    μ ~ Normal(178, 20)
    σ ~ Uniform(0, 50)

    height ~ Normal(μ, σ)
end

model = line(df.height);

# ## Output

chns = sample(model, NUTS(), 1000)

# \defaultoutput{}

# ## Original output

"""
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
""";

# ## df

df
