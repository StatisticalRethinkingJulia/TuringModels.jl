#Import Turing, Distributions and DataFrames
using CmdStan, StanMCMCChains, DataFrames, Distributions, StatsPlots

# Set a seed for reproducibility.
using Random
#Random.seed!(12);

ProjDir = @__DIR__
cd(ProjDir) #do

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

df = DataFrame(nsneeze = nsneeze_data, alcohol_taken = alcohol_data,
  nomeds_taken = meds_data, product_alcohol_meds = meds_data.*alcohol_data)
first(df, 10), last(df, 10)

# Convert the DataFrame object to matrices.

data = Matrix(df[[:alcohol_taken, :nomeds_taken, :product_alcohol_meds]])
data_labels = df[:nsneeze]
data

# # Rescale our matrices.

data = (data .- mean(data, dims=1)) ./ std(data, dims=1)

# Bayesian poisson regression (LR)

pr = "
data {
  int n;
  real s;
  int y[n];
  real x[n, 3];
}
parameters {
  real b0;
  real b1;
  real b2;
  real b3;
}
model {
  vector[n] mu;
  b0 ~ normal(0, s);
  b1 ~ normal(0, s);
  b2 ~ normal(0, s);
  b3  ~ normal(0, s);
  for ( i in 1:n ) {
      mu[i] = b0 + b1*x[i, 1] + b2*x[i,2] + b3*x[i,3];
      mu[i] = exp(mu[i]);
  }
  y ~ poisson( mu );
}
";

# Define the Stanmodel and set the output format to :mcmcchains.

stanmodel = Stanmodel(name="pr",  model=pr, output_format=:mcmcchains);

# Input data for cmdstan

prdata = Dict(
  "n" => size(data, 1),
  "s" => 10.0,
  "x" => data,
  "y" => data_labels
);
        
# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, prdata, ProjDir, diagnostics=false,
summary=true, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

# The posterior distributions obtained after sampling can be visualised as:

plot(chn)

#=
b0_exp = exp(mean(convert(Array{Float64}, chain2[:b0].value)))
b1_exp = exp(mean(convert(Array{Float64}, chain2[:b1].value)))
b2_exp = exp(mean(convert(Array{Float64}, chain2[:b2].value)))
b3_exp = exp(mean(convert(Array{Float64}, chain2[:b3].value)));

print("b0: ", b0_exp, " \n", "b1: ", b1_exp, " \n", "b2: ", b2_exp, " \n", "b3: ", b3_exp, " \n")
=#

#end