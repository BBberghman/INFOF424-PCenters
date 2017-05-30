using ArgParse

#your program should implement unix like options reading, for instance
#  -h [or --help] for help display,
#  -i [or --input] for file input, ...),
#  stdin reading and stdout writing,
#  different level of verbosity, ...
#the program has to be usable in a bash loop/script.

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--input", "--instance", "-i"
            help = "Path to the instance file"
            required = true
        "--formulation", "-f"
            help = "P1 or P3"
            required = true
        "--solver", "-s"
            help = "BaseCbc, ModCbc, Gurobi"
            required = true
        "--output", "-o"
            help = "Output file path if not using stdout"
            default = "stdout"
        "--divisor", "-d"
            help = "Divisor for valid inequality in P1. If set to -1, the new valid inequality is not considered."
            default = "-1"
        "--verbose", "-v"
            help = "Enable verbose mode 0, 1 or 2."
            default = "0"
    end

    return parse_args(s)
end

function main()
    # Parse arguments
    parsed_args = parse_commandline()

    # Instance file is checked later on, in helpers/read_instance.jl

    # Solver
    if parsed_args["solver"] != "BaseCbc" && parsed_args["solver"] != "ModCbc" && parsed_args["solver"] != "Gurobi"
      println("Solver unkown. Use BaseCbc, ModCbc or Gurobi.")
      exit(0)
    end

    # Formulation
    if parsed_args["formulation"] == "P1"
      include("P1.jl")
      result = P1(
        parsed_args["input"],
        parsed_args["solver"],
        parse(Int16, parsed_args["verbose"]),
        parse(Int16, parsed_args["divisor"])
      )
    elseif parsed_args["formulation"] == "P3"
      include("P3.jl")
      result = P3(
        parsed_args["input"],
        parsed_args["solver"],
        parse(Int16, parsed_args["verbose"]),
        parse(Int16, parsed_args["divisor"])
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
