# This file was generated, do not modify it. # hide
import CSV
import Random
import TuringModels

using DataFrames

Random.seed!(1)

data_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(data_path, DataFrame; delim=';')

dept_map = Dict(key => idx for (idx, key) in enumerate(unique(df.dept)))
df.male = [g == "male" ? 1 : 0 for g in df.gender]
df.dept_id = [dept_map[de] for de in df.dept]
df