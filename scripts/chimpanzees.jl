# ## Data

import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

file_path = joinpath(TuringModels.project_root, "data", "chimpanzees.csv") 
df = CSV.read(file_path, DataFrame; delim=';');

# ## Model

using StatsFuns
using Turing

@model function m10_3(y, x₁, x₂)
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logits = α .+ (βp .+ βpC * x₁) .* x₂
    y .~ BinomialLogit.(1, logits)
end

# ## Output

model = m10_3(df.pulled_left, df.condition, df.prosoc_left)
chns = sample(model, NUTS(), 2000)

# \defaultoutput{}

# ## Original output

"""
      Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a    0.05   0.13      -0.15       0.25  3284    1
 bp   0.62   0.22       0.28       0.98  3032    1
 bpC -0.11   0.26      -0.53       0.29  3184    1
""";

