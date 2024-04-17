
var A;
var B;

am: 0.4*A + 0.5*B <= 100;
ver: 0.5*A + 0.2*B <= 100;
pr: 0.3*A + 0.8*B <= 120;

maximize z: 500*A + 200*B;

option solver gurobi;
solve;
display A, B, z;

#A = 176.471, B = 58.8235, z = 1e+05
