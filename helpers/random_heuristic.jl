# Create a random solution containing exactly p centers
function random_heuristic(instance::PCInstance)

    solution = zeros(UInt8,instance.n)

    for i = 1:instance.p                     # p centers
        idx = rand(1:instance.n);            # randomly chosen between 1 and n
        while solution[idx] == 1
            idx = rand(1:instance.n);
        end;
        solution[idx] = 1;
    end;
    return solution
end
