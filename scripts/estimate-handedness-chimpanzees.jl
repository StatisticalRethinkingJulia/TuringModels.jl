# ## Data

import CSV
import Random
import TuringModels

using DataFrames
using StatsFuns

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "chimpanzees.csv")
df = CSV.read(data_path, DataFrame; delim=';')
first(df, 10)

# ## Model

using Turing

@model m10_4(y, actors, x₁, x₂) = begin
    ## Number of unique actors in the data set
    N_actor = length(unique(actors))

    ## Set an TArray for the priors/param
    α ~ filldist(Normal(0, 10), N_actor)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logits = α[actors] .+ (βp .+ βpC * x₁) .* x₂
    y .~ BinomialLogit.(1, logits)
end

model = m10_4(df.pulled_left, df.actor, df.condition, df.prosoc_left);

# ## Output

chns = sample(model, NUTS(), 1000)

# \defaultoutput{}

# ## Original output

m_10_04s_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
        Mean        SD       Naive SE       MCSE      ESS
a.1 -0.74503184 0.26613979 0.0042080396 0.0060183398 1000
a.2 10.77955494 5.32538998 0.0842018089 0.1269148045 1000
a.3 -1.04982353 0.28535997 0.0045119373 0.0049074219 1000
a.4 -1.04898135 0.28129307 0.0044476339 0.0056325117 1000
a.5 -0.74390933 0.26949936 0.0042611590 0.0052178124 1000
a.6  0.21599365 0.26307574 0.0041595927 0.0045153523 1000
a.7  1.81090866 0.39318577 0.0062168129 0.0071483527 1000
bp  0.83979926 0.26284676 0.0041559722 0.0059795826 1000
bpC -0.12913322 0.29935741 0.0047332562 0.0049519863 1000
";

