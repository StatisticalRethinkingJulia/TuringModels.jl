using TuringModels
using Test

@testset "sections test" begin

include("../scripts/00/section_example.jl")

@test chn1.name_map == (
  pooled = Symbol[:b, :d], 
  internals = Symbol[:elapsed, :epsilon, :eval_num, :lf_eps, :lf_num, :lp], 
  parameters = Symbol[:c, :a])
 
end

#=
@testset "mp test" begin

include("../scripts/00/mp_example.jl")

@test -10.2 < mean(chains[:a]) < -9.8
 
end
=#
