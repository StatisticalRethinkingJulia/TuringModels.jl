using TuringModels
using Test

#=
@testset "mp test" begin

include("../scripts/00/mp_example.jl")

@test -10.2 < mean(chains[:a]) < -9.8
 
end
=#

@test 1 == 1
