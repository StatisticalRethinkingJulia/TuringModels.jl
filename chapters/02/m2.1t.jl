using TuringModels
using Optim, Turing, Flux.Tracker
gr(size=(600,300));

Turing.setadbackend(:reverse_diff);

k = 6; n = 9;

@model globe_toss(n, k) = begin
  theta ~ Beta(1, 1) # prior
  k ~ Binomial(n, theta) # model
  return k, theta
end;

lb = [0.0]; ub = [1.0];

model = globe_toss(n, k);

maximum_a_posteriori(model, lb, ub)

chn = sample(model, Turing.NUTS(2000, 1000, 0.65));

chn2 = chn[1001:2000, :, :]
describe(chn2)

MCMCChains.hpd(chn2[:theta], alpha=0.055)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

