
#Import Turing, Distributions and DataFrames
using Turing, Distributions, DataFrames

# Import MCMCChain, Plots, and StatsPlots for visualizations and diagnostics.
using MCMCChains, Plots, StatsPlots

# Set a seed for reproducibility.
using Random
Random.seed!(12);

# Turn off progress monitor.
Turing.turnprogress(false)

theta_noalcohol_meds = 1    # no alcohol, took a medicine
theta_alcohol_meds = 3      # alcohol, took a medicine
theta_noalcohol_nomeds = 6  # no alcohol, no medicine
theta_alcohol_nomeds = 36   # alcohol, no medicine

# no of samples for each of the above cases

q = 1000

#Generate data from different Poisson distributions
noalcohol_meds = Poisson(theta_noalcohol_meds)
alcohol_meds = Poisson(theta_alcohol_meds)
noalcohol_nomeds = Poisson(theta_noalcohol_nomeds)
alcohol_nomeds = Poisson(theta_alcohol_nomeds)

nsneeze_data = vcat(rand(noalcohol_meds, q), rand(alcohol_meds, q), rand(noalcohol_nomeds, q), rand(alcohol_nomeds, q) )
alcohol_data = vcat(zeros(q), ones(q), zeros(q), ones(q) )
meds_data = vcat(zeros(q), zeros(q), ones(q), ones(q) )

df = DataFrame(nsneeze = nsneeze_data, alcohol_taken = alcohol_data, nomeds_taken = meds_data, product_alcohol_meds = meds_data.*alcohol_data)
first(df, 10), last(df, 10)

#Data Plotting

p1 = Plots.histogram(df[1:1000, 1], title = "no_alcohol+meds")  
p2 = Plots.histogram((df[1000:2000, 1]), title = "alcohol+meds")  
p3 = Plots.histogram((df[2000:3000, 1]), title = "no_alcohol+no_meds")  
p4 = Plots.histogram((df[3000:4000, 1]), title = "alcohol+no_meds")  
plot(p1, p2, p3, p4, layout = (2, 2), legend = false)

# Convert the DataFrame object to matrices.
data = Matrix(df[[:alcohol_taken, :nomeds_taken, :product_alcohol_meds]])
data_labels = df[:nsneeze]
data

# # Rescale our matrices.
data = (data .- mean(data, dims=1)) ./ std(data, dims=1)

# Bayesian poisson regression (LR)
@model poisson_regression(x, y, n, σ²) = begin
    b0 ~ Normal(0, σ²)
    b1 ~ Normal(0, σ²)
    b2 ~ Normal(0, σ²)
    b3  ~ Normal(0, σ²)
#     y = tzeros(Int, n)
    for i = 1:n
        theta = b0 + b1*x[i, 1] + b2*x[i,2] + b3*x[i,3]
        y[i] ~ Poisson(exp(theta))
    end
end;

# This is temporary while the reverse differentiation backend is being improved.

Turing.setadbackend(:forward_diff)
Turing.turnprogress(false)

# Retrieve the number of observations.

n, _ = size(data)

# Sample using NUTS.
chain = sample(poisson_regression(data, data_labels, n, 10), NUTS(2000, 1000, 0.65) )

describe(chain)

cmdstan_result = "
Log evidence      = 0.0
Iterations        = 1:1000
Thinning interval = 1
Chains            = 1, 2, 3, 4
Samples per chain = 1000
parameters        = b0, b1, b2, b3

Empirical Posterior Estimates
──────────────────────────────────────────
parameters
    Mean    SD   Naive SE  MCSE     ESS   
b0 1.6192 0.0101   0.0002 0.0003 1000.0000
b1 0.5269 0.0185   0.0003 0.0006  897.2201
b2 0.8859 0.0175   0.0003 0.0005 1000.0000
b3 0.3179 0.0170   0.0003 0.0006  942.7405

Quantiles
──────────────────────────────────────────
parameters
    2.5%   25.0%  50.0%  75.0%  97.5%
b0 1.5866 1.6123 1.6191 1.6262 1.6550
b1 0.4525 0.5149 0.5273 0.5393 0.5950
b2 0.8218 0.8745 0.8863 0.8976 0.9454
b3 0.2551 0.3064 0.3176 0.3292 0.3771
"

chain2 = chain[1001:2000, :, :]
describe(chain2)

size(chain2[:b0])

size(chain2[:b0].value)

b0_exp = exp(mean(convert(Array{Float64}, chain2[:b0].value)))
b1_exp = exp(mean(convert(Array{Float64}, chain2[:b1].value)))
b2_exp = exp(mean(convert(Array{Float64}, chain2[:b2].value)))
b3_exp = exp(mean(convert(Array{Float64}, chain2[:b3].value)));

print("b0: ", b0_exp, " \n", "b1: ", b1_exp, " \n", "b2: ", b2_exp, " \n", "b3: ", b3_exp, " \n")

# The posterior distributions obtained after sampling can be visualised as:

plot(chain2)
