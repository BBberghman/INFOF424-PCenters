#!/bin/sh

# Run gurobi with P3 on all instances

for i in {1..10}
do
   julia main.jl -i instances/$i.out -s Gurobi -f P3 -o out/run_all_gurobi_P3
done
