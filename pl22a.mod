
var x1 >= 3 integer; #acres milho
var x2 >= 0 integer; #acres trigo

disp: 0 <= x1+x2 <= 7;
trab: 0 <= x1*4 + x2*10 <= 40;

maximize prod: x1*10*3 + x2*25*4;
