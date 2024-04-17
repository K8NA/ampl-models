import networkx

EPS = 1.E-6

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


def solve_tsp(V, c):
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

        if addcut(ampl, edges) == False:
            if ampl.option['relax_integrality'] == False:  # solution is optimum
                break
            print("making model integer")
            ampl.option['relax_integrality'] = False

    return z, edges


if __name__ == "__main__":
    # initialize data
    from read_tsplib import read_tsplib
    try:
        V,c,x,y = read_tsplib("eil51.tsp.gz")
        c = {(i,j):c[i,j] for i in V for j in V if j>i}    # remove redundant entries
        # V,c,x,y = read_tsplib("gr17.tsp.gz")
    except:
        print("Cannot read TSPLIB file")
        exit(1)

    obj,edges = solve_tsp(V,c)
    print("\n\ntsp optimum:", obj.value())
    print("optimal tour:", edges)
