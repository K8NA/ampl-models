set GAS;
set CRUDE;

param advertising_demand;       # galons gas/$
param unit_prod_cost;           # $/galons produced
param prod_capacity;            # number galons produced

param sales_price{GAS};
param gas_octane{GAS};
param gas_sulfur{GAS};
param demand{GAS};

param purchase_quant{CRUDE};       # galons
param purchase_price{CRUDE};
param crude_octane{CRUDE};
param crude_sulfur{CRUDE};

var x{i in CRUDE, j in GAS} >= 0;   # barrels of crude oil i for produce gas j
var a{j in GAS} >= 0;               # amount spend on advertising gas j
var revenue;
var purchase_cost;
var production_cost;
var advertising_cost;
var total_cost;

maximize profit: revenue - total_cost;

REV:    revenue = sum {j in GAS} sales_price[j] * sum {i in CRUDE} x[i,j];
P:      purchase_cost = sum {i in CRUDE} purchase_price[i] * sum {j in GAS} x[i,j];
ADV:    advertising_cost = sum {j in GAS} a[j];
PROD:   production_cost = unit_prod_cost * sum {i in CRUDE, j in GAS} x[i,j];
C:      total_cost = purchase_cost + advertising_cost + production_cost;

CAPACITY:
        sum {i in CRUDE, j in GAS} x[i,j] <= prod_capacity;

PROCUREMENT {i in CRUDE}:
        sum {j in GAS} x[i,j] <= purchase_quant[i];

DEMAND {j in GAS}:
        sum {i in CRUDE} x[i,j] = demand[j] + advertising_demand * a[j];

OCTANE {j in GAS}:
        sum {i in CRUDE} crude_octane[i] * x[i,j] >= gas_octane[j] * sum {i in CRUDE} x[i,j];

SULFUR {j in GAS}:
        sum {i in CRUDE} crude_sulfur[i] * x[i,j] <= gas_sulfur[j] * sum {i in CRUDE} x[i,j];


