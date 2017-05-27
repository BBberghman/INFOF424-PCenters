# Create a random solution containing p centers
function random_heuristic(p::UInt8, n::UInt8)
    solution = fill(0,n);

    for i = 1:p                     # p centers
        idx = rand(1:n);            # randomly chosen between 1 and n
        while solution[idx] == 1
            idx = rand(1:n);
        end;
        solution[idx] = 1;
    end;
    return solution
end

# Print the index where the centers are located
function print_solution(solution::Array)
    for i = 1:instance.n 
        if (solution[i] == 1)
            println("y = 1, index: ", i )
        end
    end
end

# to change
function help()
    println(STDERR, """Usage: julia solve.jl [OPTION] [FILENAME]

  FILENAME: instance file (\"../instances/simple.txt\" by default)

  Options:
    -p = n        where n = 1 or 3 specifies the formulation used (1 by default)

    --d-sym     add constraints d_ij = d_ji
    --min-max   add lower and upper bounds constraints, calculated from minimum and maximum of d_ij""")

    exit(1)
end