include("PCInstance.jl")
include("read_instance.jl")
instance = read_instance("instances/1.out")

include("functions.jl")

solution = random_heuristic(instance.p, instance.n)

print_solution(solution)