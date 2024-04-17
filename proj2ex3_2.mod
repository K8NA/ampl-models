set P;  # programadores
set T;  # tarefas
set C;  # competencias

param disp {P};         # disponibilidade do programador P (horas)
param custo {P};        # custo do programador P (horas)
param comp_p {P, C};    # competencias C do programador P

param tempo {T};        # tempo necessario para concluir a tarefa T (horas)
param preco {T};        # preço da tarefa T
param comp_t {T, C};    # competencias C necessarias para a tarefa T (horas)

param lucro_min;        # lucro da solucao otima do ex3.1
param M;                # large integer value

var w {P, T, C} >= 0;       # horas que o programador P trabalhou na competencia C da tarefa T
var x {P, T, C} binary;     # se o programador P trabalhou na competencia C da tarefa T
var y {T} binary;           # se a tarefa T foi concluida
var z {P, T} binary;        # se o programador P trabalhou na tarefa T
var m >= 0;                 # numero de pessoas na maior equipa

subject to
TarefaConcluida {t in T}:                                           # cada tarefa só pode ser concluida 1x
    sum{p in P, c in C} w[p,t,c] >= y[t] * tempo[t];
SubtarefaConcluida {t in T, c in C}:                                # todas as tarefas de uma subtarefa concluida têm que estar concluidas
    sum{p in P} w[p,t,c] >= y[t] * comp_t[t,c];
HorasDisponiveis {p in P}:                                          # o programador nao pode exceder as suas horas disponiveis
    sum{t in T, c in C} w[p,t,c] <= disp[p];
ParticipacaoTarefa {t in T, p in P, c in C}:                        # se o programador tem mais que 0 horas na tarefa, entao participou na tarefa
    w[p,t,c] <= M * x[p,t,c];
Equipa {t in T, p in P, c in C}:                                    # se o programador trabalhou na tarefa T
    x[p,t,c] <= z[p,t];
LucroMinimo:                                                        # o lucro nao deve ser inferior ao obtido na solucao otima do ex3.1
    lucro_min <= sum{t in T} preco[t] * y[t] -
                 sum{p in P, t in T, c in C} custo[p] * w[p,t,c];
Competencias {p in P, t in T, c in C}:                              # o programador tem que ter a competencia da subtarefa
    comp_p[p,c] * x[p,t,c] >= x[p,t,c];
MaiorEquipa {t in T}:                                               # numero de programadores na maior equipa
    m >= sum{p in P} z[p,t];

minimize pessoas_na_maior_equipa: m;    # maximo entre as somas dos programadores que trabalharam na tarefa
