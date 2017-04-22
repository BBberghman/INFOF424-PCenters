using JuMP
using Cbc

include("PCInstance.jl")
include("read_instance.jl")
instance = read_instance("instances/1.out")

# Model
m = Model(solver = CbcSolver())

# Variables
@variable(m, y[1:instance.n], Bin) # (6)
@variable(m, x[1:instance.n, 1:instance.n], Bin) # (7)
@variable(m, z)

# Objective
@objective(m, Min, z)  # (1)

# Constraints
for i = 1:instance.n
  @constraint(m, sum(instance.d[i,j] * x[i,j] for j = 1:instance.n) <= z) # (2)
  @constraint(m, sum(x[i,j] for j = 1:instance.n) == 1) # (3)
  for j = 1:instance.n
    @constraint(m, x[i,j] <= y[j]) # (4)
  end
end

@constraint(m, sum(y[j] for j = 1:instance.n) <= instance.p) # (5)

# Resolution
status = solve(m)
println("Objective value: ", getobjectivevalue(m))

y2 = getvalue(y)
for i = 1:instance.n 
	if (y2[i] == 1)
		println("y = 1, index :", i)
	end
end