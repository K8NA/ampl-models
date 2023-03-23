
var x integer;
var y integer;

minX: x >= 0;
minY: y >= 0;

comp: 5*x + 6*y <= 600;
empr: 1*x + 2*y <= 160;

maximize prod: 32*x + 8*y + x*y - (x*x)/2 - y*y;
