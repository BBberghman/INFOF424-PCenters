#Select the best solution out of 1000 random solutions
function bestHeuristicRandom(instance::PCInstance)
    nb = 1000;

    solution = Array(UInt8,instance.n,nb)
    obj = zeros(UInt16,nb)

    for i = 1:nb
        solution[:,i] = random_heuristic(instance);
        obj[i] = obj_value(solution[:,i], instance);
    end;

    bestZ = minimum(obj);
    bestSol = zeros(UInt8,instance.n)
    for i = 1:nb 
        if obj[i] == bestZ 
            bestSol = solution[:,i]
            break;
        end;
    end;
    return bestSol
end
