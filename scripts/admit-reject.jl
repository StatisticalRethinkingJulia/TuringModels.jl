# ## Data

using CSV
using DataFrames
using StatsFuns
using Turing

import TuringModels

file_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(file_path, DataFrame; delim=';')

# ## Model

@model m_pois(admit, reject) = begin
   α₁ ~ Normal(0,100)
   α₂ ~ Normal(0,100)

   for i ∈ 1:length(admit)
       λₐ = exp(α₁)
       λᵣ = exp(α₂)
       admit[i] ~ Poisson(λₐ)
       reject[i] ~ Poisson(λᵣ)
   end
end;

# ## Output

chns = sample(m_pois(df.admit, df.reject), NUTS(0.65), 1000)

# \defaultoutput{}

# ## Original output

m_10_yyt_result = "
    mean   sd 5.5% 94.5% n_eff Rhat
 a1 4.99 0.02 4.95  5.02  2201    1
 a2 5.44 0.02 5.41  5.47  2468    1
";

