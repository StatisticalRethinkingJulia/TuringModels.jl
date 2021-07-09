# This file was generated, do not modify it. # hide
import CSV
import Random
import TuringModels

using DataFrames
using RData
using LinearAlgebra

Random.seed!(1)

data_dir = joinpath(TuringModels.project_root, "data")
kline_path = joinpath(data_dir, "Kline2.csv")
df = CSV.read(kline_path, DataFrame; delim=';')

dmat_path = joinpath(data_dir, "islandsDistMatrix.rda")
dmat = load(dmat_path)["islandsDistMatrix"]

df.society = 1:10;
df