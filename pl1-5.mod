
var fit >= 0;
var bob >= 0;

maxFit: fit <= 6000;
maxBob: bob <= 4000;

horas: fit/200 + bob/140 <= 40;

maximize z: 25*fit + 30*bob; #lucro semanal

option solver gurobi;
solve;
display fit, bob, z;

#fit = 6000, bob = 1400, z = 192000
#steel-a
