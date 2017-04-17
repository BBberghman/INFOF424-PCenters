# TODO
# Choose integer types wisely

# Read
file = open("instances/1.out")
lines = readlines(file)

# Parse
n = parse(Int64, split(lines[1], ":")[2])
println("N: $n")

p = parse(Int64, split(lines[2], ":")[2])
println("p: $n")

d = zeros(n,n)

offset = 3
for i=1:n
  line_splitted = split(lines[i+offset], "\t")
  for j=1:n
    #println(line_splitted[j])
    d[i, j] = parse(Int64, line_splitted[j])
  end
end

#print(d)
