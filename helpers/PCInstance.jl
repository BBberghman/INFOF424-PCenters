type PCInstance
  n::UInt8
  p::UInt8
  d::Matrix{UInt16}
  K::UInt16
  rho::Array{UInt16}
end

function describe_instance(instance::PCInstance)
  return string("PCInstance:\n",
    "- N:\t", instance.n, "\n",
    "- p:\t", instance.p, "\n"
  )
end
