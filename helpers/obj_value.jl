# Create a random solution containing p centers
function obj_value(solution::Array{UInt8}, instance::PCInstance)
        
    dic_min = fill(typemax(Int16), instance.n);     #distance i to center
    
    #for each point compute smaller distance to all centers
    for i = 1:instance.n
        A = solution .* instance.d[i,:];        #keep j = centers
        xij_centers = A[find(A)];           
        dic_min[i] = minimum(xij_centers);      #take the smallest one
    end;
    
    #max of these distances
    z = maximum(dic_min);
    
    return(z)
end


