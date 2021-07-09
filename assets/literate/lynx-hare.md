<!--This file was generated, do not modify it.-->
```julia:ex1
# hideall

import Random

using TuringModels

Random.seed!(1)

output_dir = TuringModels.output_dir("lynx-hare") # hide
mkpath(output_dir)

function write_gadfly_svg(name, p; width=6inch, height=4inch)
    TuringModels.write_gadfly_svg(output_dir, name, p; width, height)
end
nothing
```

## Data

```julia:ex2
using DataFrames
using DifferentialEquations
using Gadfly
```

First, we simulate population dynamics with the Lotka-Volterra model.

```julia:ex3
function lotka_volterra(du, u, p, t)
  x, y = u
  α, β, γ, δ = p
  du[1] = (α - β*y)x
  du[2] = (δ*x - γ)y
end

p = [1.5, 1.0, 3.0, 1.0]
u0 = [1.0, 1.0]
prob1 = ODEProblem(lotka_volterra, u0, (0.0, 10.0), p)
sol = solve(prob1, Tsit5(); saveat=0.1)
nothing # hide
```

To plot it, we convert the data to a DataFrame first

```julia:ex4
function data2df(time, hare, lynx; index=1)
    df = DataFrame(
        time = time,
        hare = hare,
        lynx = lynx
    )
    sdf = stack(df, [:hare, :lynx]; variable_name=:group, value_name=:number)
    sdf[!, :index] .= index
    sdf
end

timesteps = 1:length(sol)
time = sol.t[timesteps]
hare = sol[1, timesteps]
lynx = sol[2, timesteps]

df_original = data2df(time, hare, lynx)
write_gadfly_svg("data", # hide
plot(df_original, x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.2))
) # hide
nothing # hide
```

\fig{data.svg}

To make the data more realistic, the example from the Turing tutorials adds random noise:

```julia:ex5
sol_noise = solve(prob1, Tsit5(); saveat=0.1)
odedata = Array(sol_noise) + 0.8 * randn(size(Array(sol_noise)))

time = sol_noise.t[timesteps]
hare = odedata[1, :]
lynx = odedata[2, :]
df_noise = data2df(time, hare, lynx)

write_gadfly_svg("data_noise", # hide
plot(df_noise, x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.2))
) # hide
nothing # hide
```

\fig{data_noise.svg}

## Model

```julia:ex6
using CategoricalArrays
using Turing
Turing.setadbackend(:forwarddiff)

@model function fitlv(data, prob1)
    σ ~ InverseGamma(2, 3)
    α ~ truncated(Normal(1.5, 0.5), 0.5, 2.5)
    β ~ truncated(Normal(1.2, 0.5), 0, 2)
    γ ~ truncated(Normal(3.0, 0.5), 1, 4)
    δ ~ truncated(Normal(1.0, 0.5), 0, 2)

    p = [α, β, γ, δ]
    prob = remake(prob1; p)
    predicted = solve(prob, Tsit5(); saveat=0.1)

    for i = 1:length(predicted)
        data[:,i] ~ MvNormal(predicted[i], σ)
    end
end

model = fitlv(odedata, prob1);
```

## Output

```julia:ex7
chns = sample(model, NUTS(), MCMCThreads(), 1000, 3)
```

\defaultgadflyoutput{}

We can verify the outcome by retrodicting, that is, comparing the predictions with the true values.
Similar to the Turing tutorial, we do this with some randomly picked posterior samples.

```julia:ex8
function posterior_sol(index)
    posterior_p_subset = Array(chns)[rand(1:1500), 1:4]
    prob = remake(prob1; p=posterior_p_subset)
    retro_sol = solve(prob, Tsit5(); saveat=0.1)
    timesteps = 1:length(retro_sol)

    time = retro_sol.t[timesteps]
    hare = retro_sol[1, timesteps]
    lynx = retro_sol[2, timesteps]
    data2df(time, hare, lynx; index)
end

samples = 1:100
dfs = posterior_sol.(samples)
df_retro = vcat(dfs...)

df_retro.index = categorical(df_retro.index)
hare_samples = filter(:group => ==("hare"), df_retro)
lynx_samples = filter(:group => ==("lynx"), df_retro)

write_gadfly_svg("retrofitted", # hide
plot(
    layer(hare_samples, x=:time, y=:number, color=:index,
        Geom.smooth(method=:loess, smoothing=0.2),
        Theme(; line_width=0.1mm, alphas=[0.3])
    ),
    layer(lynx_samples, x=:time, y=:number, color=:index,
        Geom.smooth(method=:loess, smoothing=0.2),
        Theme(; line_width=0.1mm, alphas=[0.3])
    ),
    layer(df_original, x=:time, y=:number, color=:group,
        Geom.point, Geom.smooth(method=:loess, smoothing=0.2)
    ),
    Theme(; key_position=:none)
)
) # hide
nothing # hide
```

\fig{retrofitted.svg}

This is where the Statistical Rethinking books ends, for an example of handling missing data, see the Turing tutorials.

