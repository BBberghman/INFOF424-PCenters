using JuMP
using Cbc

include("Instance.jl")
include("read_instance.jl")
instance = read_instance("instances/1.out")

# Model
m = Model(solver = CbcSolver())

# Variables
@variable(m, y[1:instance.n], Bin) # (6)
@variable(m, x[1:instance.n,1:instance.n], Bin) # (7)
@variable(m, z)

# Objective
# TODO: define objective properly (max value of sums, not sum of sums)
# draft: maximum(sum(instance.d[i][j] * x[i][j] for j=1:instance.n) for i=1:instance.n))
# working non-solution: sum(sum(instance.d[i,j] * x[i,j] for j = 1:instance.n) for i = 1:instance.n)
@objective(m, Min, z)  # (1)

# Constraints
for i = 1:instance.n
  @constraint(m, sum(instance.d[i, j] * x[i, j] for j = 1:instance.n) <= z) # (2)
  @constraint(m, sum(x[i,j] for j = 1:instance.n) == 1) # (3)
  for j = 1:instance.n
    @constraint(m, x[i,j] <= y[j]) # (4)
  end
end

@constraint(m, sum(y[i] for i = 1:instance.n) <= instance.p) # (5)

# Resolution
#print(m)
status = solve(m)
println("Objective value: ", getobjectivevalue(m))
