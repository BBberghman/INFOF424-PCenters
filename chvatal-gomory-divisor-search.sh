#!/bin/sh

# Run gurobi with P1 on all instances

for i in {1..3}
do
  for j in 25 50 75 100 125 150 175 200 225 250 275
  do
    julia main.jl -i instances/$i.out -s Cbc -f P1 -d $j -o out/chvatal-gomory-divisor-search
  done
done
