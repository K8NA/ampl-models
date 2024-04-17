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
ampl.read("gcp.mod")
ampl.set['V'] = V
ampl.set['E'] = E
Kmax = len(V)
ampl.param['Kmax'] = Kmax

ampl.solve()
K = ampl.obj['K']
print("Colors used:", K.value())

y = ampl.var['y']
x = ampl.var['x']
for k in range(1,Kmax+1):
    if y[k].value() > .5:
        vk = [i for i in V if x[i,k].value() >.5]
        print("color {} used in {}".format(k,vk))
