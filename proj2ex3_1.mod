set P;  # programadores
set T;  # tarefas
set C;  # competencias

param disp {P};         # disponibilidade do programador P (horas)
param custo {P};        # custo do programador P (horas)
param comp_p {P, C};    # competencias C do programador P

param tempo {T};        # tempo necessario para concluir a tarefa T (horas)
param preco {T};        # preço da tarefa T
param comp_t {T, C};    # competencias C necessarias para a tarefa T (horas)

var w {P, T, C} >= 0;       # horas que o programador P trabalhou na competencia C da tarefa T
var x {P, T, C} binary;     # se o programador P trabalhou na competencia C da tarefa T
var y {T} binary;           # se a tarefa T foi concluida

subject to
TarefaConcluida {t in T}:                               # cada tarefa só pode ser concluida 1x
    sum{p in P, c in C} w[p,t,c] >= y[t] * tempo[t];
SubtarefaConcluida {t in T, c in C}:                    # todas as tarefas de uma subtarefa concluida têm que estar concluidas
    sum{p in P} w[p,t,c] >= y[t] * comp_t[t,c];
HorasDisponiveis {p in P}:                              # o programador nao pode exceder as suas horas disponiveis
    sum{t in T, c in C} w[p,t,c] <= disp[p];
Competencias {p in P, t in T, c in C}:                  # o programador tem que ter a competencia da subtarefa
    comp_p[p,c] * x[p,t,c] >= x[p,t,c];

maximize lucro: sum{t in T} preco[t] * y[t] -                       # soma do preco das tarefas concluidas -
                sum{p in P, t in T, c in C} custo[p] * w[p,t,c];    # custo/hora dos programadores * horas que os programadores trabalharam
