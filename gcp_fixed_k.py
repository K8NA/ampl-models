import random
# prepare data
def make_data(n,prob):
    """make_data: prepare data for a random graph
    Parameters:
        - n: number of vertices
        - prob: probability of existence of an edge, for each pair of vertices
    Returns a tuple with a list of vertices and a list edges.
       """
    V = list(range(1,n+1))
    E = [(i,j) for i in V for j in V if i < j and random.random() < prob]
    return V,E


V, E = make_data(10, .5)

from amplpy import AMPL, Environment, DataFrame
ampl = AMPL()
ampl.option['solver'] = 'gurobi'
ampl.read("gcp_fixed_k.mod")
ampl.set['V'] = V
ampl.set['E'] = E

LB = 0
UB = len(V)
while UB - LB > 1:
    K = (UB + LB) // 2
    print("current K:{}\t[LB:{},UB:{}]".format(K,LB,UB))
    ampl.param['K'] = K
    ampl.solve()
    Z = ampl.obj['Z']
    print("Bad edges:", Z.value())

    if Z.value() > .5:
        LB = K
        z = ampl.var['z']
        for (i, j) in E:
            if z[i, j].value() > .5:
                print("Bad edge:", (i, j))
    else:
        UB = K
        x = ampl.var['x']
        for k in range(1, K + 1):
            vk = [i for i in V if x[i, k].value() > .5]
            print("color {} used in {}".format(k, vk))

print()
print("Chromatic number:", UB)
print("color {} used in {}".format(k, vk))
