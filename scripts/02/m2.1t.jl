# # m2.1t.jl

# Load Julia packages (libraries) needed

using TuringModels

# ### snippet 2.8t

# Define the data

k = 6; n = 9;

# Define the model

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end;

# Use Turing mcmc

chns = sample(globe_toss(n, k), NUTS(0.65), 1000)

# Look at the proper draws (in corrected chn2)

chns |> display

# Show the hpd region

hpd(chns, alpha=0.055) |> display

# End of `02/m2.1t.jl`
