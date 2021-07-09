# This file was generated, do not modify it. # hide
import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

file_path = joinpath(TuringModels.project_root, "data", "chimpanzees.csv")
df = CSV.read(file_path, DataFrame; delim=';');