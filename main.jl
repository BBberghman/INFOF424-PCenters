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
        "--output", "-o"
            help = "Output file if not stdout"
            default = "stdout"
        "--solver", "-s"
            help = "Solver method:\nCbcBase: Base Cbc without any optimization (careful, this might last long)\nModCbc: Cbc with some optmizations\nGurobi: Fast, standard solver which implements optimizations on its own"
        "--verbose", "-v"
            help = "Enable verbose mode"
            action = :store_true
        "arg1"
            help = "a positional argument"
            required = true
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    println("Parsed args:")
    for (arg,val) in parsed_args
        println("  $arg  =>  $val")
    end
end

main()
