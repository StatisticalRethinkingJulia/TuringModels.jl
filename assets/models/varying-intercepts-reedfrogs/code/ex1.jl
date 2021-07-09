# This file was generated, do not modify it. # hide
import CSV
import Random

using DataFrames
using TuringModels

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "reedfrogs.csv")
df = CSV.read(data_path, DataFrame; delim=';');
@assert size(df) == (48, 5) ## hide
df.tank_index = 1:nrow(df)
df