# This file was generated, do not modify it. # hide
@model function model_fn(y, x₁, x₂)
  σ ~ truncated(Cauchy(0, 2), 0, Inf)
  βAR ~ Normal(0, 10)
  βR ~ Normal(0, 10)
  βA ~ Normal(0, 10)
  α ~ Normal(0, 100)

  μ = α .+ βR * x₁ .+ βA * x₂ .+ βAR * x₁ .* x₂
  y ~ MvNormal(μ, σ)
end

model = model_fn(df.log_gdp, df.rugged, df.cont_africa);