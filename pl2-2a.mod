
var x1 >= 0; #acres milho
var x2 >= 0; #acres trigo

gov: x1 >= 3;
disp: x1+x2 <= 7;
trab: x1/4 + x2/10 <= 40;

maximize prod: 10*3*x1 + 25*4*x2;

option solver gurobi;
solve;
display x1, x2, prod;

# x1 = 3, x2 = 4, prod = 490
