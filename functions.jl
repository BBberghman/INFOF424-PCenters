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