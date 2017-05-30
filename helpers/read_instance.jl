function read_instance(path)
  try
    file = open(path)
    lines = readlines(file)

    n = parse(UInt8, split(lines[1], ":")[2])
    println("N: $n")

    p = parse(UInt8, split(lines[2], ":")[2])
    println("p: $p")

    d = zeros(UInt16,n,n)
    offset = 3
    for i = 1:n
      line_splitted = split(lines[i+offset], "\t")
      for j = 1:n
        d[i, j] = parse(UInt16, line_splitted[j])
      end
    end

    K = parse(UInt16, split(lines[n+offset+3], ":")[2])
    println("K: $K")

    rho = zeros(UInt16, K)
    for i = 1:K
  	   rho[i] = parse(UInt16, lines[i+n+offset+5])
    end
    
    close(file)

    return PCInstance(n,p,d,K,rho)
  catch
    println("Instance file invalid")
    exit(0)
  end
end
