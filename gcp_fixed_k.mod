set V;
set E within {V,V};
param K;
set C := {1..K};

var x {V, C} binary;
var z {E} binary;

minimize Z: sum {(i,j) in E} z[i,j];

subject to
Color {i in V}: sum {k in C} x[i,k] = 1;
BadEdge {(i,j) in E, k in C}: x[i,k] + x[j,k] <= 1 + z[i,j];
