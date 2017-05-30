# INFOF424 Combinatorial Optimization Project

## The p-Center Problem

Authors : Erica Berghman & Charles Hamesse

Implementation in Julia language combined with the JuMP package of two formulations of the p-Center Problem:

- The formulation proposed by Daskin (1995).
- The formulation proposed by Calik and Tansel (2013).

These formulations can be found in [1], pages 2992 and 2993 respectively.

All the information on this project can be found in `report/INFO-F424-P.pdf`.

## Example run

```
julia main. jl −i INPUT −f FORMULATION −s SOLVER [−o OUTPUT] [−d DIVISOR] [−c INITIAL−CANDIDATE] [−v VERBOSE] [−h]
```
Where :

- `INPUT` is the input instance file (which has to respect the format of the ones in the `instances` folder),
- `FORMULATION` is either `P1` or `P3`,
- `SOLVER` is either `Cbc` or `Gurobi`,
- `OUTPUT` is the output file, if not specified the output will be stdout
- `DIVISOR` is the divisor used to compute valid inequalities (leaving blank does not add any VI)
- `INITIAL-CANDIDATE` is the heuristic method for the hot start (`random` or `2approx`)
- `VERBOSE` is the verbosity level, `0` or `1`.

## References

[1] Calik H, Tansel BC (2013) Double bound method for solving the p-center location problem. Comput Oper
Res 40:2991–2999
