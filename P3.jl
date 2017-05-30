using JuMP
using Gurobi
using Cbc

include("helpers/PCInstance.jl")
include("helpers/Result.jl")
include("helpers/read_instance.jl")
include("helpers/print_solution.jl")
include("helpers/random_heuristic.jl")
include("helpers/twoapprox_heuristic.jl")
include("helpers/bestHeuristicRandom.jl")
include("helpers/bestHeuristicTwoApprox.jl")
include("helpers/obj_value.jl")

function P3(argInstance, argSolver, argInitialCandidate, argDivisor, argVerbose)

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
  if argSolver == "CbcBase" || argSolver == "ModCbc"
    m = Model(solver = CbcSolver())
  elseif argSolver == "Gurobi"
    m = Model(solver = GurobiSolver(OutputFlag=argVerbose))
  end

  # Variables
  @variable(m, y[1:instance.n], Bin) # (18)
  @variable(m, z[1:instance.K], Bin) # (19)
  
  # Initial candidate
  if argInitialCandidate != "default"
    if argInitialCandidate == "random"
      initial_candidate = bestHeuristicRandom(instance)
    elseif argInitialCandidate == "2approx"
      initial_candidate = bestHeuristicTwoApprox(instance)
    end
    
    rhoK = obj_value(initial_candidate, instance)       #value of rhoK corresponding to the initial solution
    #gives the value of the subscript K
    init_z = zeros(Bin, instance.K);
    for k = 1:instance.K 
        if (rhoK == instance.rho[k])
            init_z[k] = 1;
        end;
    end;
            
    setvalue(z, init_z)
    setvalue(y, initial_candidate)
  end

  # Objective
  @objective(m, Min, sum(instance.rho[k] * z[k] for k = 1:instance.K))  # (14)

  # Parameter a
  a = zeros(instance.n, instance.n, instance.K)

  # Constraints
  for i = 1:instance.n
    for k = 1:instance.K
      for j = 1:instance.n
  		instance.d[i,j] <= instance.rho[k] ? a[i,j,k] = 1 : nothing
  	end
      @constraint(m, sum(a[i,j,k] * y[j] for j = 1:instance.n) >= z[k]) # (15)
    end
  end

  @constraint(m, sum(y[j] for j = 1:instance.n) <= instance.p) # (16)
  @constraint(m, sum(z[k] for k = 1:instance.K) == 1) # (17)

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
