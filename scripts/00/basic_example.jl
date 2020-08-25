using TuringModels
#using StatsPlots

ProjDir = @__DIR__

# Define a simple Normal model with unknown mean and variance.

@model gdemo(x, y) = begin
  s ~ InverseGamma(2, 3)
  m ~ Normal(0, sqrt(s))
  x ~ Normal(m, sqrt(s))
  y ~ Normal(m, sqrt(s))
end

#  Run sampler, collect results

chn = sample(gdemo(1.5, 2), NUTS(0.65), 1000)

# Summarise results (currently requires the master branch from MCMCChains)

chn |> display

# Plot and save results if in ./dev

#p = plot(chn)
#savefig("$(ProjDir)/basic-example-plot.png")
