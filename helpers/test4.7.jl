using JuMP
using Gurobi

# Model
m = Model(solver = GurobiSolver())

# Variables
@variable(m, x1, Int)
@variable(m, x2, Int)

# Objective
@objective(m, Max, 9*x1 + 5*x2)  # (1)

# Constraints
@constraint(m, x1 <= 6)
@constraint(m, x1 - 3*x2 >= 1)
@constraint(m, 3*x1 + 2*x2 <= 19)

# Resolution
tic();
status = solve(m)
println("Objective value: ", getobjectivevalue(m))
toc();
