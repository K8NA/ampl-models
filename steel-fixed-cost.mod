var XF;   # toneladas de fitas produzidas
var YF;   # indicador da produção de fitas
var XB;   # toneladas de bobinas produzidas
var YB;   # indicador da produção de bobinas

var XF >= 0;
var YF binary;
var XB >= 0;  
var YB binary;

subject to
Tempo: XF/200 + XB/140  + 4*YF + 12*YB <= 40;
LimiteF: XF <= 6000 * YF;
LimiteB: XB <= 4000 * YB;

maximize lucro: 25*XF + 30*XB;
