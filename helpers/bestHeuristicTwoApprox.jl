#Select the best solution out of 10 solutions found by the 2-approx heuristic
function bestHeuristicTwoApprox(instance::PCInstance)
    nb = 10;
    
    solution = Array(UInt8,instance.n,nb)
    obj = zeros(UInt16,nb)
    
    for i=1:nb
        solution[:,i] = twoapprox_heuristic(instance);
        obj[i] = obj_value(solution[:,i], instance);
    end;
    
    println(maximum(obj));
    bestZ = minimum(obj);
    println(bestZ)
    solution = solution[:,find(bestZ)];
    return solution
end