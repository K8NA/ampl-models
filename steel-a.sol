Problem:    teorica
Rows:       4
Columns:    2
Non-zeros:  6
Status:     OPTIMAL
Objective:  lucro = 192000 (MAXimum)

   No.   Row name   St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 Tempo        NU            40                          40          4200
     2 LimiteF      NU          6000             0          6000             4
     3 LimiteB      B           1400             0          4000 
     4 lucro        B         192000                             

   No. Column name  St   Activity     Lower bound   Upper bound    Marginal
------ ------------ -- ------------- ------------- ------------- -------------
     1 XF           B           6000                             
     2 XB           B           1400                             

Karush-Kuhn-Tucker optimality conditions:

KKT.PE: max.abs.err. = 3.12e-16 on row 1
        max.rel.err. = 7.62e-18 on row 1
        High quality

KKT.PB: max.abs.err. = 0.00e+00 on row 0
        max.rel.err. = 0.00e+00 on row 0
        High quality

KKT.DE: max.abs.err. = 9.37e-16 on column 2
        max.rel.err. = 3.02e-17 on column 2
        High quality

KKT.DB: max.abs.err. = 0.00e+00 on row 0
        max.rel.err. = 0.00e+00 on row 0
        High quality

End of output
