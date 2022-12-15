# This file was generated, do not modify it. # hide
@model function line(height)
    μ ~ Normal(178, 20)
    σ ~ Uniform(0, 50)

    height ~ Normal(μ, σ)
end

model = line(df.height);