# # m2.1t.jl

# Load Julia packages (libraries) needed

using TuringModels
using Optim, Turing, Flux.Tracker
gr(size=(600,300));

#-

Turing.setadbackend(:reverse_diff);
#nb Turing.turnprogress(false);

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

# Fix the inclusion of adaptation samples

chn2 = MCMCChains.Chains(chn.value[1001:2000,:,:], 
  vcat(chn.name_map[:internals], chn.name_map[:parameters]),
  Dict(
    :parameters => chn.name_map[:parameters],
    :internals => chn.name_map[:internals]
  )
)

# Look at the proper draws (in corrected chn2)

describe(chn2)

# Show the hpd region

MCMCChains.hpd(chn2, alpha=0.055)

# Compute the hpd bounds for plotting

d, p, c = size(chn2);
theta = convert(Vector{Float64}, reshape(chn2.value[:, 7, :], (d*c)));
bnds = quantile(theta, [0.045, 0.945])

# Show hpd region

println("hpd bounds = $bnds\n")

# analytical calculation

w = 6; n = 9; x = 0:0.01:1
plot( x, pdf.(Beta( w+1 , n-w+1 ) , x ), fill=(0, .5,:orange), lab="Conjugate solution")

# quadratic approximation

plot!( x, pdf.(Normal( 0.67 , 0.16 ) , x ), lab="Normal approximation")

# Turing Chain &  89%hpd region boundaries

#tmp = convert(Array{Float64,3}, chn.value[:, 4, :])
#draws = reshape(tmp, (size(tmp, 1)*size(tmp, 3)),)
density!(chn.value[:, 2, 1], lab="Turing chain")
vline!([bnds[1]], line=:dash, lab="hpd lower bound")
vline!([bnds[2]], line=:dash, lab="hpd upper bound")

# End of `02/m2.1t.jl`
