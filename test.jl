using JuMP
using Cbc

include("helpers/PCInstance.jl")
include("helpers/read_instance.jl")
include("helpers/2approx.jl")
include("helpers/print.jl")
include("helpers/random.jl")
include("helpers/obj_value.jl")
include("helpers/bestHeuristicRandom.jl")
include("helpers/bestHeuristicMix.jl")
include("helpers/bestHeuristicTwoApprox.jl")


instance = read_instance("instances/1.out")

println("Random")
tic()
solution = bestHeuristicRandom(instance)
toc()

println("2-approx")
tic()
solution = bestHeuristicTwoApprox(instance)
toc()

println("Mix")
tic()
solution = bestHeuristicMix(instance)
toc()
