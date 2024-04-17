
var x >= 0 integer; #n de vids com 2 cabecas por dia
var y >= 0 integer; #n de vids com 4 cabecas por dia

comp: 5*x + 6*y <= 600;
empr: 1*x + 2*y <= 160;

maximize prod: 32*x + 8*y + x*y - (x*x)/2 - y*y;

option solver gurobi;
solve;
display x, y;

#72, 40
