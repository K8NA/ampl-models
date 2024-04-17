
var port >= 0;
var desk >= 0;

mont: port/9 + desk/8 <= 40;
qual: port/10 + desk/16 <= 40;

mark: desk <= port;

maximize z: 250*port + 150*desk;

option solver gurobi;
solve;
display port, desk, z;

#port = 360, desk = 0, z = 90000
