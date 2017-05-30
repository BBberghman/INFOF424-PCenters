# INFOF424 Combinatorial Optimization Project
## The p-Center Problem

Authors : Erica Berghman & Charles Hamesse

Implementation in Julia language combined with the JuMP package of two formulations of the p-Center Problem:

- The formulation proposed by Daskin (1995).
- The formulation proposed by Calik and Tansel (2013).

These formulations can be found in [1], pages 2992 and 2993 respectively.



## Running

Example run:
```
julia main.jl -i instances/1.out -s Gurobi -f P1
instances/1.out	Gurobi	P1	-1	127	12.212337933
```


### References
[1] Calik H, Tansel BC (2013) Double bound method for solving the p-center location problem. Comput Oper
Res 40:2991–2999
