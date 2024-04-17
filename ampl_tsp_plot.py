import networkx
import matplotlib.pyplot as plt    
import math
import random
import networkx

LOG = True
EPS = 1.e-6


def draw(V, position, edges, name):
    print(position)
    plt.ion()
    G = networkx.Graph()
    plt.clf()                         # clear the canvas
    # plt.title(name)
    G.add_nodes_from(V)
    for (i,j) in edges:
        G.add_edge(i,j)
    networkx.draw(G, position, with_labels=True, font_size=6, node_size=75, node_color='yellow')
    plt.savefig("tsp_%s.pdf" % name, format='pdf', dpi=300)
    # plt.show()
    # input("[press enter]")

def addcut(ampl, edges):
    G = networkx.Graph()
    G.add_edges_from(edges)
    Components = list(networkx.connected_components(G))

    if len(Components) == 1:
        return False

    n = int(ampl.param['n'].value() + .5)
    for S in Components:
        n += 1
        ampl.param['n'] = n
        ampl.set['S'][n] = S
        print("cut: len(%s) <= %s" % (S, len(S) - 1))
    return True


def solve_tsp(V, c, position=None):
    """solve_tsp -- solve the traveling salesman problem
       - start with assignment model
       - add cuts until there are no sub-cycles
    Parameters:
        - V: set/list of nodes in the graph
        - c[i,j]: cost for traversing edge (i,j)
    Returns the optimum objective value and the list of edges used.
    """


    # setup and solve the problem
    from amplpy import AMPL, Environment, DataFrame
    ampl = AMPL()
    ampl.option['solver'] = 'gurobi'
    ampl.option['relax_integrality'] = True
    ampl.read("tsp.mod")
    ampl.set['V'] = V
    ampl.param['c'] = c
    ampl.param['n'] = 0

    while True:
        ampl.solve()
        z = ampl.obj['z']
        print("current obj:", z.value())

        x = ampl.var['x']
        edges = [(i,j) for i in V for j in V if i < j and x[i,j].value() > EPS]
        print("edges:", edges)

        if position:
            if ampl.option['relax_integrality']:
                n = int(ampl.param['n'].value())
                print(n)
                draw(V, position, edges, name=f"{n:02}")
            else:
                draw(V, position, edges, name="final")

        if addcut(ampl, edges) == False:
            if ampl.option['relax_integrality'] == False:  # solution is optimal
                break
            print("making model integer")
            ampl.option['relax_integrality'] = False

    return z, edges


if __name__ == "__main__":
    # initialize data
    import sys
    from read_tsplib import read_tsplib
    try:
        V,c,x,y = read_tsplib(sys.argv[1])
        c = {(i,j):c[i,j] for i in V for j in V if j>i}    # remove redundant entries
    except:
        print("Cannot read TSPLIB file {sys.argv[1]}")
        print("usage: {sys.argv[0]} tsp_instance")
        exit(1)

    position = {i:(x[i], y[i]) for i in V}
    draw(V, position, edges=[], name="cities")
        
    obj,edges = solve_tsp(V, c, position)
    print("\n\ntsp optimum:", obj.value())
    print("optimal tour:", edges)
