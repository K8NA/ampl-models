
var x1 >= 0; #toneladas escolhidas para tratamento
var x2 >= 0;
var x3 >= 0;

minimize cost: 15*x1 + 10*x2 + 20*x3;

ReducePollutant1: 0.1*x1 + 0.2*x2 + 0.4*x3 >= 30;
ReducePollutant2: 0.45*x1 + 0.25*x2 + 0.3*x3 >= 40;

option solver gurobi;
solve;
display x1, x2, x3, cost;
