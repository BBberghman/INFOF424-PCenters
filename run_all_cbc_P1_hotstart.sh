#!/bin/sh

# Run gurobi with P1 on all instances with random initial candidate

for i in {1..10}
do
   julia main.jl -i instances/$i.out -s Cbc -f P1 -o out/run_all_cbc_P1 -c 2approx
done
