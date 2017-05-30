#!/bin/sh

# Run gurobi with P1 on all instances

for i in {1..10}
do
   julia main.jl -i instances/$i.out -s Gurobi -f P1 -o out/run_all_gurobi_P1
done
