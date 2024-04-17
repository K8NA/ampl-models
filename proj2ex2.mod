set P;  # programadores
set T;  # tarefas
set C;  # competencias

param disp {P};             # disponibilidade do programador P (horas)
param custo {P};            # custo do programador P (horas)
param comp_p {P, C};        # competencias C do programador P
param avaliacao {P, C};     # avaliacao do programador P na competencia C

param tempo {T};            # tempo necessario para concluir a tarefa T (horas)
param preco {T};            # preço da tarefa T
param comp_t {T, C};        # competencias C necessarias para a tarefa T (horas)

param lucro_min;            # lucro da solucao otima do ex1

var x {P, T} binary;    # se o programador P concluiu a tarefa T
var y {T} binary;       # se a tarefa T foi concluida

subject to
TarefaConcluida {t in T}: sum{p in P} x[p,t] = y[t];                           # cada tarefa só pode ser completada uma vez
LucroMinimo: lucro_min <= sum{t in T} preco[t] * y[t] -                         # o lucro nao deve ser inferior ao obtido na solucao otima do ex1
                          sum{p in P, t in T} custo[p] * x[p,t] * tempo[t];
HorasDisponiveis {p in P}: sum{t in T} x[p,t] * tempo[t] <= disp[p];            # o programador nao pode exceder as suas horas disponiveis
Competencias {p in P, t in T, c in C}: comp_p[p,c] * comp_t[t,c] >=             # o programador tem que ter todas as competencias da tarefa
                                       comp_t[t,c] * x[p,t];

maximize sum_avaliacao: sum{p in P, t in T, c in C} x[p,t] *    # soma da avaliacao dos programadores por competencia *
                        comp_t[t,c] * avaliacao[p,c];           # horas de competencia em cada subtarefa
