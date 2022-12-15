# This file was generated, do not modify it. # hide
import CSV

using TuringModels: project_root
using DataFrames

path = joinpath(project_root, "data", "chimpanzees.csv")
df = CSV.read(path, DataFrame; delim=';');