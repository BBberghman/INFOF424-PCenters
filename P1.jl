using JuMP
using Clp

# Model
m = Model(solver = ClpSolver())

# Variables
@variable(m, y[1:n], Bin) # (6)
@variable(m, x[1:n,1:n], Bin) # (7)

# Objective
@objective(m, Min, maximum(sum(d[i][j] * x[i][j] for j=1:n) for i=1:n)) # (1), (2)

# Constraints
for i = 1:n
  @constraint(m, sum(x[i][j] for j=1:n) == 1) # (3)
  for j = 1:n
    @constraint(m, x[i][j] <= y[j]) # (4)
  end
end

@constraint(m, sum(y[i] for i=1:n) <= p) # (5)

# Resolution
print(m)
status = solve(m)
println("Objective value: ", getobjectivevalue(m))
