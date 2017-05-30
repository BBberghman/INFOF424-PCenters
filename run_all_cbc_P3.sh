#!/bin/sh

# Run cbc with P3 on all instances

for i in {2..5}
do
   julia main.jl -i instances/$i.out -s Cbc -f P3 -o out/run_all_cbc_P3 -c 2approx
done
