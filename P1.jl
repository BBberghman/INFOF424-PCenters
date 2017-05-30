using JuMP
using Cbc
using Gurobi

include("helpers/PCInstance.jl")
include("helpers/Result.jl")
include("helpers/read_instance.jl")
include("helpers/2approx.jl")
include("helpers/random.jl")
include("helpers/print.jl")
include("helpers/bestHeuristicRandom.jl")
include("helpers/bestHeuristicTwoApprox.jl")
include("helpers/obj_value.jl")

function P1(argInstance, argSolver, argInitialCandidate, argDivisor, argVerbose)

  # Instance
  instance = read_instance(argInstance)

  # Verbose
  if argVerbose >= 1
    print(describe_instance(instance))
    println(string(
      "Execution:\n",
      "- Solver:\t", argSolver, "\n",
      "- Initial candidate:\t", argInitialCandidate, "\n",
      "- Divisor:\t", argDivisor, "\n"
    ))
  end

  # Model
  if argSolver == "Cbc"
    m = Model(solver = CbcSolver())
  elseif argSolver == "Gurobi"
    m = Model(solver = GurobiSolver(OutputFlag=argVerbose))
  end

  # Variables
  @variable(m, y[1:instance.n], Bin) # (6)
  @variable(m, x[1:instance.n, 1:instance.n], Bin) # (7)
  @variable(m, z)


  # Initial candidate
  if argInitialCandidate != "default"
    if argInitialCandidate == "random"
      initial_candidate = bestHeuristicRandom(instance)
    elseif argInitialCandidate == "2approx"
      initial_candidate = bestHeuristicTwoApprox(instance)
    end
    setvalue(y, initial_candidate)
  end

  # Objective
  @objective(m, Min, z)  # (1)

  # Constraints
  for i = 1:instance.n
    @constraint(m, sum(instance.d[i,j] * x[i,j] for j = 1:instance.n) <= z) # (2)

    # Divisor
    if argDivisor > - 1
        @constraint(m, sum( floor(instance.d[i,j]/argDivisor) * x[i,j] for j = 1:instance.n) <= z/argDivisor) # (2 + VI)
    end

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
  score =  getobjectivevalue(m)
  execution_time = toq();
  if argVerbose >= 1
    println("Objective value: ", score)
    y2 = getvalue(y)
    print_solution(instance, y2)
  end

  return Result(score, execution_time)
end
