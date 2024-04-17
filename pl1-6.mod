
var bife >= 0;
var fran >= 0;
var peixe >= 0;
var hamb >= 0;
var mac >= 0;
var emp >= 0;
var esparg >= 0;
var peru >= 0;

A: 60*bife + 8*fran + 8*peixe + 40*hamb + 15*mac + 70*emp + 25*esparg + 60*peru >= 700;
C: 20*bife + 20*peixe + 40*hamb + 35*mac + 30*emp + 50*esparg + 20*peru >= 700;
B1: 10*bife + 20*fran + 15*peixe + 35*hamb + 15*mac + 15*emp + 25*esparg + 15*peru >= 700;
B2: 15*bife + 20*fran + 10*peixe + 10*hamb + 15*mac + 15*emp + 15*esparg + 10*peru >= 700;

minimize custo: 319*bife + 259*fran + 229*peixe + 289*hamb + 189*mac + 199*emp + 199*esparg + 249*peru;

option solver gurobi;
solve;
display bife, fran, peixe, hamb, mac, emp, esparg, peru, custo;

# 46 pratos de mac por semana
