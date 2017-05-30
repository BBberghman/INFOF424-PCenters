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
        "--verbose", "-v"
            help = "Enable verbose mode"
            action = :store_true
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    println("Parsed args:")
    for (arg,val) in parsed_args
        println("  $arg  =>  $val")
    end

    include("P1.jl")
    P1(parsed_args["input"], parsed_args["solver"], "a", "a")

end

main()
