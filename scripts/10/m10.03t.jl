using TuringModels, StatsFuns

Turing.setadbackend(:reverse_diff);
#Turing.turnprogress(false);

d = DataFrame(CSV.read(joinpath(@__DIR__, "..", "..", "data", "chimpanzees.csv"),
  delim=';'));
size(d) # Should be 504x8

# pulled_left, condition, prosoc_left
@model m10_3(y, x₁, x₂) = begin
    α ~ Normal(0, 10)
    βp ~ Normal(0, 10)
    βpC ~ Normal(0, 10)

    for i ∈ 1:length(y)
        p = logistic(α + (βp + βpC * x₁[i]) * x₂[i])
        y[i] ~ Binomial(1, p)
    end
end;

chns = sample(m10_3(d[:,:pulled_left], d[:,:condition], d[:,:prosoc_left]),
  Turing.NUTS(0.95), 2000);

# Rethinking result

m_10_03t_result = "
      Mean StdDev lower 0.89 upper 0.89 n_eff Rhat
 a    0.05   0.13      -0.15       0.25  3284    1
 bp   0.62   0.22       0.28       0.98  3032    1
 bpC -0.11   0.26      -0.53       0.29  3184    1
";

# Describe the draws

describe(chns)

# End of m10.03t.jl