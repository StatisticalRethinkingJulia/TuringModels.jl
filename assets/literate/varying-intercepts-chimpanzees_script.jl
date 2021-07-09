# This file was generated, do not modify it.

import CSV

using TuringModels: project_root
using DataFrames

path = joinpath(project_root, "data", "chimpanzees.csv")
df = CSV.read(path, DataFrame; delim=';');

using Turing

@model m12_4(pulled_left, actor, condition, prosoc_left) = begin
    # Total num of y
    N = length(pulled_left)

    # Separate σ priors for each actor
    σ_actor ~ truncated(Cauchy(0, 1), 0, Inf)

    # Number of unique actors in the data set
    N_actor = length(unique(actor)) #7

    # Vector of actors (1,..,7) which we'll set priors on
    α_actor ~ filldist(Normal(0, σ_actor), N_actor)

    # Prior for intercept, prosoc_left, and the interaction
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    logitp = α .+ α_actor[actor] .+
            (βp .+ βpC * condition) .* prosoc_left

    pulled_left .~ BinomialLogit.(1, logitp)
end;

chns = sample(
    m12_4(df.pulled_left, df.actor, df.condition, df.prosoc_left),
    NUTS(),
    1000
)

m124rethinking = "
             Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a_actor[1]  -1.13   0.95      -2.62       0.27  2739    1
 a_actor[2]   4.17   1.66       1.80       6.39  3958    1
 a_actor[3]  -1.44   0.95      -2.90      -0.02  2720    1
 a_actor[4]  -1.44   0.94      -2.92      -0.04  2690    1
 a_actor[5]  -1.13   0.94      -2.58       0.31  2727    1
 a_actor[6]  -0.19   0.94      -1.64       1.25  2738    1
 a_actor[7]   1.34   0.97      -0.09       2.87  2889    1
 a            0.42   0.93      -1.00       1.81  2622    1
 bp           0.83   0.26       0.41       1.25  8594    1
 bpC         -0.13   0.30      -0.62       0.34  8403    1
 sigma_actor  2.26   0.94       1.07       3.46  4155    1
";

