# This file was generated, do not modify it. # hide
@model function model_fn(log_gdp_std, rugged_std, mean_rugged)
    α ~ Normal(1, 0.1)
    β ~ Normal(0, 0.3)
    σ ~ Exponential(1)

    μ = α .+ β * (rugged_std .- mean_rugged)
    log_gdp_std ~ MvNormal(μ, σ)
end

model = model_fn(df.log_gdp, df.rugged_std, mean(df.rugged_std));