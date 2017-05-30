using JuMP
using Cbc

include("helpers/PCInstance.jl")
include("helpers/read_instance.jl")
include("helpers/print.jl")
include("helpers/random.jl")
include("helpers/2approx.jl")
instance = read_instance("instances/1.out")

# Initial candidate
#initial_candidate = make2approx(instance)

# Model
m = Model(solver = CbcSolver())

# Variables
@variable(m, y[1:instance.n], Bin) # (6)
#setvalue(y, initial_candidate)
@variable(m, x[1:instance.n, 1:instance.n], Bin) # (7)
@variable(m, z)

# Objective
@objective(m, Min, z)  # (1)

divisor = 140
println("divisor: ", divisor)

# Constraints
for i = 1:instance.n
  @constraint(m, sum(instance.d[i,j] * x[i,j] for j = 1:instance.n) <= z) # (2)
  @constraint(m, sum( floor(instance.d[i,j]/divisor) * x[i,j] for j = 1:instance.n) <= z/divisor) # (2 + VI)
  @constraint(m, sum(x[i,j] for j = 1:instance.n) == 1) # (3)
  for j = 1:instance.n
    @constraint(m, x[i,j] <= y[j]) # (4)
  end
end

@constraint(m, sum(y[j] for j = 1:instance.n) <= instance.p) # (5)
@constraint(m, sum(y[j] for j = 1:instance.n) >= 1) # (4')

# Resolution
tic();
status = solve(m)
println("Objective value: ", getobjectivevalue(m))
toc();

y2 = getvalue(y)
print_solution(y2)
