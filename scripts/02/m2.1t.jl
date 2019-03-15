# # m2.1t.jl

# Load Julia packages (libraries) needed

using TuringModels
using Optim, Turing, Flux.Tracker
gr(size=(600,300));

#-

Turing.setadbackend(:reverse_diff);
#nb Turing.turnprogress(false)

# ### snippet 2.8t

# Define the data

k = 6; n = 9;

# Define the model

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end;

# Compute the "maximum_a_posteriori" value

# Set search bounds

lb = [0.0]; ub = [1.0];

# Create (compile) the model 

model = globe_toss(n, k);

# Compute the maximum_a_posteriori

maximum_a_posteriori(model, lb, ub)

# Use Turing mcmc

chn = sample(model, Turing.NUTS(2000, 1000, 0.65));

# Look at the proper draws (in corrected chn2)

chn2 = chn[1001:2000, :, :]
describe(chn2)

# Show the hpd region

MCMCChains.hpd(chn2[:theta], alpha=0.055)

# End of `02/m2.1t.jl`
