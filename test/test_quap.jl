using Turing, CSV

ProjDir = @__DIR__

include("../src/quap_turing.jl")

df = CSV.read(joinpath(@__DIR__, "..", "data", "Howell1.csv"))

# Use only adults and center the weight observations

df2 = filter(row -> row.age >= 18, df)
mean_weight = mean(df2.weight)
df2.weight_c = df2.weight .- mean_weight
first(df2, 5)

@model height(heights) = begin
    μ ~ Normal(178, 20)
    σ ~ Uniform(0, 50)
    heights .~ Normal(μ, σ)
end

m = height(df2.height)
res = quap(m)
MvNormal(res.coef, res.vcov)
