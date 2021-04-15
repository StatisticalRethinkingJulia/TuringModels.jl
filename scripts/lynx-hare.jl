## hideall
using TuringModels

output_dir = TuringModels.output_dir("lynx-hare") # hide
mkpath(output_dir)

function write_gadfly_svg(name, p; width=6inch, height=4inch)
    TuringModels.write_gadfly_svg(output_dir, name, p; width, height)
end
nothing

# ## Data

using DataFrames
using DifferentialEquations
using Gadfly

# First, we simulate population dynamics with the Lotka-Volterra model.

function lotka_volterra(du, u, p, t)
  x, y = u
  α, β, γ, δ = p
  du[1] = (α - β*y)x
  du[2] = (δ*x - γ)y
end

p = [1.5, 1.0, 3.0, 1.0]
u0 = [1.0, 1.0]
prob1 = ODEProblem(lotka_volterra, u0, (0.0, 10.0), p)
sol = solve(prob1, Tsit5())
timesteps = 1:length(sol)
nothing # hide

# To plot it, we convert the data to a DataFrame first

function sol2df(sol)
    df = DataFrame(
        time = [sol.t[i] for i in timesteps],
        hare = [sol[1,i] for i in timesteps],
        lynx = [sol[2,i] for i in timesteps]
    )
    stack(df, [:hare, :lynx]; variable_name=:group, value_name=:number)
end

write_gadfly_svg("data", # hide
plot(sol2df(sol), x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.15))
) # hide
nothing # hide

# \fig{data.svg}

#

# To make the data more realistic, the example from the Turing tutorials adds random noise:

sol_noise = solve(prob1, Tsit5(), saveat=0.1)
odedata = Array(sol1) + 0.8 * randn(size(Array(sol1)))

write_gadfly_svg("data_noise", # hide
plot(sol2df(sol_noise), x=:time, y=:number, color=:group,
    Geom.point, Geom.smooth(method=:loess, smoothing=0.15))
) # hide
nothing # hide

# \fig{data_noise.svg}

# ## Model
