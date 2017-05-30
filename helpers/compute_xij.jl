# Compute the x_ij coeffcient of formulation P1 given a solution and an instance
function compute_xij(solution::Array{UInt8}, instance::PCInstance)
    
    dic_min = zeros(UInt16, instance.n);     #distance i to center
    x = zeros(UInt8, instance.n, instance.n);
    
    
    for i = 1:instance.n
        A = solution .* instance.d[i,:];        #keep j = centers
        xij_centers = A[find(A)];           
        dic_min = minimum(xij_centers);      #smallest distance between the point and all the centers
        for j = 1:instance.n
            if (dic_min == instance.d[i,j] && solution[j] == 1) # for that distance the point is associated to that center
                x[i,j] = 1;
                break;          #and is associated to only one center
            end;
        end;
    end;
    
    return(x)
end


