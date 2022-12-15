using TuringModels
using Test

TestDir = @__DIR__
testfiles = readdir(joinpath(TestDir, "..", "scripts"))

@testset "TuringModels" begin
    exclude_testfiles = "non-identifiable.jl"

    for tf in testfiles
        if tf !in exclude_testfiles
            println("\n\ntesting $tf.\n")
            include("../scripts/$tf")
        end
    end
end
