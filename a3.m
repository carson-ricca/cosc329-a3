% Define variable indices.
D=1;
A=2;
T=3;
NH=4;
C=5;

% Define the directed acyclic graph and edges.
dag = zeros(5,5);
dag(D, [A T NH]) = 1;
dag(NH, C) = 1;

% Define node sizes and create model structure.
node_sizes = [2 2 3 2 2];
bnet = mk_bnet(dag, node_sizes);
bnet.dag;