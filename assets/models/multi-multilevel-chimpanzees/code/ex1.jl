# This file was generated, do not modify it. # hide
import CSV
import Random

using TuringModels: project_root
using DataFrames

Random.seed!(1)

path = joinpath(project_root, "data", "chimpanzees.csv")
df = CSV.read(path, DataFrame; delim=';');