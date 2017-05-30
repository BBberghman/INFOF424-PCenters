#Select the best solution out of 10 solutions found by the 2-approx heuristic and 1000 random solutions
function bestHeuristicMix(instance::PCInstance)
    nb1 = 500;
    nb2 = 500;
    nb = nb1 + nb2;

    solution = Array{Array{UInt8}}(nb)
    obj = zeros(UInt16,nb)

    for i = 1:nb1
        solution[i] = twoapprox_heuristic(instance);
        obj[i] = obj_value(solution[i], instance);
    end;


    for i = nb1+1:nb
        solution[i] = random_heuristic(instance);
        obj[i] = obj_value(solution[i], instance);
    end;
    println(maximum(obj));
    bestZ = minimum(obj);
    println(bestZ)
    solution = solution[find(bestZ)];

    return solution
end
