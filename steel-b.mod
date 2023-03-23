# declaracao de conjuntos para indexacao:
set PROD;  # conjunto de todos os produtos que se fabricam

# declaracao dos parametros
param rate {PROD} > 0;     # toneladas produzidas por hora
param avail >= 0;          # horas de trabalho disponiveis numa semana
param profit {PROD};       # lucro por tonelada, para cada produto
param market {PROD} >= 0;  # limite nas toneladas de cada produto 
                           # vendidas numa semana

# declaracao das variaveis
var Make {p in PROD} >= 0, <= market[p]; # toneladas produzidas por semana

# declaracao do objectivo:
# lucros totais, vindos de todos os produtos
maximize total_profit: sum {p in PROD} profit[p] * Make[p];
# (para indexar os produtos, utilizou-se a expressao 'p in PROD')

# restricao: total das horas utilizadas em todos os produtos nao 
# devera exceder as horas disponiveis
subject to Time: sum {p in PROD} (1/rate[p]) * Make[p] <= avail;
