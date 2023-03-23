# PRIMEIRA ETAPA: declaracao das variaveis utilizando a
# instrucao 'var'
var XF;   # numero de fitas produzidas
var XB;   # numero de bobinas produzidas

# SEGUNDA ETAPA: declaracao das restricoes utilizando a
# instrucao 'subject to ___:'
subject to Tempo: XF/200 + XB/140 <= 40;  # tempo
                          # disponivel por semana
subject to LimiteF: 0 <= XF <= 6000;
# a instrucao 'subject to ' e facultativa; exemplo:
LimiteB: 0 <= XB <= 4000;

# TERCEIRA ETAPA: declaracao do objectivo,  utilizando a
# instrucao 'maximize' (ou 'minimize')
maximize lucro: 25*XF + 30*XB;

