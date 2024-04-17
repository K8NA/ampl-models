set CRUDE;   # raw materials
set INTERM;  # intermediate products
set GAS;     # final products

param advertising_demand;       # barrels gas/$
param unit_dist_cost;           # $/barrels produced
param unit_blend_cost;          # $/barrels produced
param unit_crack_cost;          # $/barrels produced
param destil_capacity;          # number barrels distilled
param crack_capacity;           # number barrels cracked

param sales_price{GAS};
param gas_octane{GAS};
param demand{GAS};

param d{CRUDE,INTERM};          # conversion factor at distillery
param c{INTERM,INTERM};         # conversion factor at cracking
param purchase_quant{CRUDE};    # barrels
param purchase_price{CRUDE};
param interm_octane{INTERM};

var z{k in CRUDE} >= 0;   # barrels of crude k to buy
var y0{j in INTERM} >= 0; # barrels of intermediate product j to produce in distillation
var y1{j in INTERM} >= 0; # barrels of intermediate product j to produce in cracking
var y2{j in INTERM} >= 0; # barrels of intermediate product j to use in blending
var v{i in GAS} >= 0;     # barrels of gas i to produce
var x{j in INTERM, i in GAS} >= 0;     # barrels of intermediate j to use to produce gas i
var a{i in GAS} >= 0;                  # amount spend on advertising gas i
var revenue;
var purchase_cost;
var production_cost;
var advertising_cost;
var total_cost;

maximize profit: revenue - total_cost;

REV:    revenue = sum {i in GAS} sales_price[i] * v[i];
P:      purchase_cost = sum {k in CRUDE} purchase_price[k] * z[k];
ADV:    advertising_cost = sum {i in GAS} a[i];
PROD:   production_cost = unit_dist_cost * sum {k in CRUDE} z[k] +
                          unit_crack_cost * sum {j in INTERM} y1[j] +
                          unit_blend_cost * sum {j in INTERM} y2[j];
COST:   total_cost = purchase_cost + advertising_cost + production_cost;

DEST_CAPACITY:
        sum {i in CRUDE} z[i] <= destil_capacity;

DEMAND {i in GAS}:
        v[i] = demand[i] + advertising_demand * a[i];

PROCUREMENT {k in CRUDE}:
        z[k] <= purchase_quant[k];

OCTANE {i in GAS}:
        sum {j in INTERM} interm_octane[j] * x[j,i] >= gas_octane[i] * v[i];

SULFUR {j in GAS}:
        sum {i in CRUDE} crude_sulfur[i] * x[i,j] <= gas_sulfur[j] * v[j];

DISTIL {j in INTERM}:
        y0[j] = sum {k in CRUDE} d[k,j] * z[k];

BLEND {i in GAS}:
        v[i] = sum {j in INTERM} x[j,i];

BOM {j in INTERM}:
        y2[j] = sum {i in GAS} x[j,i];

CRACKING {j in INTERM}:
        y2[j] = y0[j] - y1[j] + sum {j_ in INTERM} c[j_,j] * y1[j_];

CRACK_CAPACITY:
        sum {j in INTERM} y1[j] <= crack_capacity;
