include("helpers/PCInstance.jl")
include("helpers/read_instance.jl")
include("helpers/random.jl")
include("helpers/2approx.jl")

instance = read_instance("instances/1.out")

solution = make2approx(instance) # or random_heuristic(instance.p, instance.n)

print(solution)

for i = 1:instance.n
	if (solution[i] == 1)
		println("y = 1, index: ", i )
	end
end
