set PROG;  # programadores
set TASK;  # tarefas
set COMP;  # competencias

param disp {PROG};         # disponibilidade do programador PROG (horas)
param custo {PROG};        # custo do programador PROG (horas)
param comp_p {PROG, COMP};    # competencias COMP do programador PROG

param tempo {TASK};        # tempo necessario para concluir a tarefa TASK (horas)
param preco {TASK};        # preço da tarefa TASK
param comp_t {TASK, COMP};    # competencias COMP necessarias para a tarefa TASK (horas)

var x {PROG, TASK} binary;    # se o programador PROG concluiu a tarefa TASK
var y {TASK} binary;       # se a tarefa TASK foi concluida

subject to
TarefaConcluida {t in TASK}: sum{p in PROG} x[p,t] = y[t];                   # cada tarefa só pode ser completada uma vez
HorasDisponiveis {p in PROG}: sum{t in TASK} x[p,t] * tempo[t] <= disp[p];    # o programador nao pode exceder as suas horas disponiveis
Competencias {p in PROG, t in TASK, c in COMP}: comp_p[p,c] * comp_t[t,c] >=     # o programador tem que ter todas as competencias da tarefa
                                       comp_t[t,c] * x[p,t];


maximize lucro: sum{t in TASK} preco[t] * y[t] -                       # soma do preco das tarefas concluidas -
                sum{p in PROG, t in TASK} custo[p] * x[p,t] * tempo[t];   # custo/hora dos programadores * horas que os programadores trabalharam
