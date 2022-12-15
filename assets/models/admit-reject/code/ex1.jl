# This file was generated, do not modify it. # hide
import Random
import TuringModels

using CSV
using DataFrames
using StatsFuns
using Turing

Random.seed!(1)

file_path = joinpath(TuringModels.project_root, "data", "UCBadmit.csv")
df = CSV.read(file_path, DataFrame; delim=';')