function evaluate(instance, x)
  return sum(instance.d[i,j] * x[i,j] for j = 1:instance.n)
end

function twoapprox_heuristic(instance)

  # init center list
  centers = zeros(Int16,instance.p)

  # pick a first center randomly
  centers[1] = rand(1:instance.n)

  # loop for all remaining centers to find
  nleft = instance.p - 1
  while nleft > 0
    outer_max = typemin(Int16)
    outer_max_idx = -1

    # for all rows (vertices)
    for i = 1:instance.n
      if !in(i, centers)
        # get the min distance from all assigned centers
        inner_min = typemax(Int16) # integer max value
        for j = centers
          if j > 0
            if instance.d[i,j] < inner_min
              inner_min = instance.d[i, j]
            end
          end
        end

        # if it's further than all others, save it
        if inner_min > outer_max
          outer_max = inner_min
          outer_max_idx = i
        end
      end
    end

    # add it to centers
    centers[instance.p + 1 - nleft] = outer_max_idx

    # decrement
    nleft -= 1
  end

  # write solution
  solution = zeros(UInt8,instance.n);

  for i = centers
      solution[i] = 1;
  end
  return solution
end
