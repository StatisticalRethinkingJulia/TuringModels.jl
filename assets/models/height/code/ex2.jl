# This file was generated, do not modify it. # hide
@model function line(height)
    σ ~ Uniform(0, 50)
    μ ~ Normal(178, 20)

    height .~ Normal.(μ, σ)
end

model = line(df.height);