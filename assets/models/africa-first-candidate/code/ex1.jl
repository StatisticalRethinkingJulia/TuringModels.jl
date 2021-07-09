# This file was generated, do not modify it. # hide
using DataFrames
using Turing
using TuringModels

import CSV

data_path = joinpath(TuringModels.project_root, "data", "rugged.csv")
df = CSV.read(data_path, DataFrame)

df.log_gdp = log.(df.rgdppc_2000)
dropmissing!(df)

df = select(df, :log_gdp, :rugged, :cont_africa);

df.log_gdp_std = df.log_gdp ./ mean(df.log_gdp)
df.rugged_std = df.rugged ./ maximum(df.rugged)

first(df, 8)