
set GAS;
set CRUDE;

param NAPHTHA_OCTANE;
param OIL_OCTANE;
param DIST_LIMIT;
param DIST_COST;
param BLEND_COST;
param AD_EFFECT;

# para o ex2
param CRACK_LIMIT;
param CRACK_COST;
param CRACKED_OCTANE;

param OCTANE_RATING{GAS};
param DEMAND{GAS};
param PRICE{GAS};

param NAPHTHA{CRUDE};
param OIL{CRUDE};
param COST{CRUDE};
param BUY_LIMIT{CRUDE};

var gb{GAS} >= 0; #barris?
var ad{GAS} >= 0; #advertising
var bn{GAS} >= 0; #barris nathpha
var bo{GAS} >= 0; #barris oil
var bc{GAS} >= 0; #barris cracked

var cb{CRUDE} >= 0;

var total_naphtha >= 0;
var total_oil >= 0;
var total_cracked >= 0;

maximize profit: (sum {g in GAS} (gb[g]*PRICE[g])) -
                 (sum {c in CRUDE} (cb[c]*COST[c])) -
                 ((sum {c in CRUDE} (cb[c]))*DIST_COST) -
                 ((sum {g in GAS} (gb[g]))*BLEND_COST) -
                 (sum {g in GAS} (ad[g]));

buy {c in CRUDE}: cb[c] <= BUY_LIMIT[c];

dist: sum {c in CRUDE} (cb[c]) <= DIST_LIMIT;

naphthaLim: sum {c in CRUDE} (cb[c]*NAPHTHA[c]) = total_naphtha;

oilLim: sum {c in CRUDE} (cb[c] - OIL[c]) = total_oil;

blend_n: sum {g in GAS} (bn[g]) <= total_naphtha;

blend_o: sum {g in GAS} (bo[g]) <= total_oil;

octane {g in GAS}: bn[g]*NAPHTHA_OCTANE + bo[g]*OIL_OCTANE
                   >= OCTANE_RATING[g]*gb[g];

blend_nl {g in GAS}: bn[g] + bo[g] = gb[g];

dem {g in GAS}: gb[g] = DEMAND[g] + ad[g]*AD_EFFECT;


# para o ex2

maximize profit2: (sum {g in GAS} (gb[g]*PRICE[g])) -
                 (sum {c in CRUDE} (cb[c]*COST[c])) -
                 ((sum {c in CRUDE} (cb[c]))*DIST_COST) -
                 ((sum {g in GAS} (gb[g]))*BLEND_COST) -
                 (sum {g in GAS} (ad[g])) -
                 ((sum {g in GAS} (bc[g]))*CRACK_COST);

cracked: total_cracked = sum {g in GAS} (bc[g]);  # +

crack_limit: total_cracked <= CRACK_LIMIT;  # +

new_blend_nl {g in GAS}: bn[g] + bo[g] + bc[g] = gb[g];  # ~

new_octane {g in GAS}: bn[g]*NAPHTHA_OCTANE + bo[g]*OIL_OCTANE
                       + bc[g]*CRACKED_OCTANE >= OCTANE_RATING[g]*gb[g];  # ~

oil_limit: sum {g in GAS} (bo[g] + bc[g]) = total_oil;
