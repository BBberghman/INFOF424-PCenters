# Print the index where the centers are located
function print_solution(instance, solution::Array)
    for i = 1:instance.n
        if (solution[i] == 1)
            println("y = 1, index: ", i )
        end
    end
end