# Print the index where the centers are located
function print_solution(instance::PCInstance, solution::Array)
    println("Centers located in: ")
    for i = 1:instance.n
        if (solution[i] == 1)
            println(i, " ")
        end
    end
end