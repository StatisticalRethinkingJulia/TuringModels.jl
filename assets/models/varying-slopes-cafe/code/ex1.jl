# This file was generated, do not modify it. # hide
import CSV
import Random

using DataFrames
using TuringModels

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "d_13_1.csv")
df = CSV.read(data_path, DataFrame);