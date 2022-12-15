# This file was generated, do not modify it. # hide
import CSV
import Random

using DataFrames
using Turing
using TuringModels

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "rugged.csv")
df = CSV.read(data_path, DataFrame)

df.log_gdp = log.(df.rgdppc_2000)
dropmissing!(df)

df = select(df, :log_gdp, :rugged, :cont_africa);