## Grading

The grading should respect the following scheme (the grading scale is indicative and can be modified at any moment):

1. 13 points can be obtained on the correct solving of the benchmark instances

2. 3 points can be taken by offering a decent Human Machine Interface. It means, that your program should implement unix like options reading (for instance -h [or --help] for help display, -i [or --input] for file input, ...), stdin reading and stdout writing, different level of verbosity, ...
Note however that the program has to be usable in a bash loop/script.

3. 4 points on the optimization of your model. In other words, the faster your model runs, the better it is. This can be done in a lot of ways:

- reduce the number of variables
- add valid inequalities
- use cutting planes algorithm
- hot starts
- ...

You are free to use whatever you want to increase the performance of your model. Note that you have to provide both models (the initial one the optimized). To finish, the maximum amount of points in this part can be earned if the implementation of your model runs faster than mine.

## To-do

1. Correct solving of the benchmark instances: export results
2. Unix options: help, input, different levels of verbosity. Make usable in bash script
3. Optimizations:

  - Reduce number of variables: not much to do
  - VI: floored some VI, no effect on gurobi but  great effect on cbc
  - Cutting planes: to-do
  - Hot starts: to tweak
