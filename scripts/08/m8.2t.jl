using TuringModels

@model m8_2(y) = begin

    σ ~ FlatPos(0.0) # improper prior with probability one everywhere above 0.0
    α ~ Flat() # improper prior with pobability one everywhere

    y .~ Normal(α, σ)
end

y = [-1,1];

# Sample

chns = sample(m8_2(y), NUTS(0.65), 1000)

# Describe the posterior samples

chns |> display

# End of `08/m8.2t.jl`
