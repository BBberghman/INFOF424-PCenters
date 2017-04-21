# cf https://github.com/JuliaOpt/JuMP.jl/tree/master/examples

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

# Objective
# TODO: define objective properly (max value of sums, not sum of sums)
# draft: maximum(sum(instance.d[i][j] * x[i][j] for j=1:instance.n) for i=1:instance.n))
@objective(m, Min, sum(sum(instance.d[i,j] * x[i,j] for j=1:instance.n) for i=1:instance.n))  # (1), (2)

# Constraints
for i = 1:instance.n
  @constraint(m, sum(x[i,j] for j=1:instance.n) == 1) # (3)
  for j = 1:instance.n
    @constraint(m, x[i,j] <= y[j]) # (4)
  end
end

@constraint(m, sum(y[i] for i=1:instance.n) <= instance.p) # (5)

# Resolution
#print(m)
status = solve(m)
println("Objective value: ", getobjectivevalue(m))