include("PCInstance.jl")
include("read_instance.jl")
instance = read_instance("instances/1.out")

include("functions.jl")

solution = random_heuristic(instance.p, instance.n)

for i = 1:instance.n
	if (solution[i] == 1)
		println("y = 1, index: ", i )
	end
end
