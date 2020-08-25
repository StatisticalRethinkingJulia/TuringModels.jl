using TuringModels

# Turing model
@model m8_3(y) = begin
    α ~ Normal(1, 10)
    σ ~ truncated(Cauchy(0, 1), 0, Inf)

    y .~ Normal(α, σ)
end

y = [-1,1]

# Sample

chns = sample(m8_3(y), NUTS(0.95), 1000);

# Results rethinking

m83rethinking = "
      mean   sd  5.5% 94.5% n_eff Rhat
alpha 0.09 1.63 -2.13  2.39   959    1
sigma 2.04 2.05  0.68  4.83  1090    1
";

# Describe the posterior samples

chns |> display

# End of `08/m8.3t.jl`
