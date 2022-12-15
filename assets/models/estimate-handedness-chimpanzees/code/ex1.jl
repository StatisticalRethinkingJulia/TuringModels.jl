# This file was generated, do not modify it. # hide
import CSV
import Random
import TuringModels

using DataFrames
using StatsFuns

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "chimpanzees.csv")
df = CSV.read(data_path, DataFrame; delim=';')
first(df, 10)