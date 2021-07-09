# ## Data

import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

delim = ';'
data_path = joinpath(TuringModels.project_root, "data", "Kline.csv")
df = CSV.read(data_path, DataFrame; delim)

df.log_pop = log.(df.population)
df.contact_high = [contact == "high" ? 1 : 0 for contact in df.contact]
df

# ## Model

using Turing

@model m10_10stan(total_tools, log_pop, contact_high) = begin
    α ~ Normal(0, 100)
    βp ~ Normal(0, 1)
    βc ~ Normal(0, 1)
    βpc ~ Normal(0, 1)

    for i ∈ 1:length(total_tools)
        λ = exp(α + βp*log_pop[i] + βc*contact_high[i] +
            βpc*contact_high[i]*log_pop[i])
        total_tools[i] ~ Poisson(λ)
    end
end;

# ## Output

chns = sample(
    m10_10stan(df.total_tools, df.log_pop, df.contact_high), 
    NUTS(),
    1000
)

# \defaultoutput{}

# ## Original output

m_10_10t_result = "
     mean   sd  5.5% 94.5% n_eff Rhat
 a    0.94 0.37  0.36  1.53  3379    1
 bp   0.26 0.04  0.21  0.32  3347    1
 bc  -0.08 0.84 -1.41  1.23  2950    1
 bpc  0.04 0.09 -0.10  0.19  2907    1
";

