# TODO
# Choose integer types wisely

# Read
function read_instance(path)
  file = open(path)
  lines = readlines(file)

  # Parse
  n = parse(Int64, split(lines[1], ":")[2])
  println("N: $n")

  p = parse(Int64, split(lines[2], ":")[2])
  println("p: $n")

  d = zeros(Int64, n,n)
  offset = 3
  for i=1:n
    line_splitted = split(lines[i+offset], "\t")
    for j=1:n
      #println(line_splitted[j])
      d[i, j] = parse(Int64, line_splitted[j])
    end
  end

  return Instance(n,p,d)
end
