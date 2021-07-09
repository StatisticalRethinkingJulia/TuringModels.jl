# This file was generated, do not modify it. # hide
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