using ArgParse

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--input", "--instance", "-i"
            help = "Path to the instance file."
            required = true
        "--formulation", "-f"
            help = "P1 or P3."
            required = true
        "--solver", "-s"
            help = "Cbc or Gurobi."
            required = true
        "--output", "-o"
            help = "Output file path."
            default = "stdout"
        "--divisor", "-d"
            help = "Divisor for valid inequality in P1. If set to -1, the new valid inequality is not considered."
            default = "-1"
        "--initial-candidate", "-c"
            help = "Heuristic for hot start. Use default, random or 2approx."
            default = "default"
        "--verbose", "-v"
            help = "Enable verbose mode. 0 or 1."
            default = "0"
    end

    return parse_args(s)
end

function main()
    # Parse arguments
    parsed_args = parse_commandline()

    # Instance file is checked later on, in helpers/read_instance.jl

    # Solver
    if parsed_args["solver"] != "Cbc" && parsed_args["solver"] != "Gurobi"
      println("Solver unkown. Use Cbc or Gurobi.")
      exit(0)
    end

    # Initial candidate
    if parsed_args["initial-candidate"] != "random" && parsed_args["initial-candidate"] != "default" && parsed_args["initial-candidate"] != "2approx"
      println("Initial candidate method unkown. Use default, random or 2approx.")
      exit(0)
    end

    # Formulation
    if parsed_args["formulation"] == "P1"
      include("P1.jl")
      result = P1(
        parsed_args["input"],
        parsed_args["solver"],
        parsed_args["initial-candidate"],
        parse(Int16, parsed_args["divisor"]),
        parse(Int16, parsed_args["verbose"])
      )
    elseif parsed_args["formulation"] == "P3"
      include("P3.jl")
      result = P3(
        parsed_args["input"],
        parsed_args["solver"],
        parsed_args["initial-candidate"],
        parse(Int16, parsed_args["divisor"]),
        parse(Int16, parsed_args["verbose"])
      )
    else
      println("Formulation unkown. Use P1 or P3")
      exit(0)
    end

    # Output
    str = string(
      parsed_args["input"], "\t",
      parsed_args["solver"], "\t",
      parsed_args["formulation"], "\t",
      parsed_args["initial-candidate"], "\t",
      parsed_args["divisor"], "\t",
      result.score, "\t",
      result.time, "\n"
    )
    if parsed_args["output"] != "stdout"
      try
        open(parsed_args["output"], "a") do f
          write(f, str)
        end
      catch
        println("Output file invalid")
      end
    end

    print(str)

end

main()
