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

% Define difficulty with uniform distribution.
bnet.CPD{B} = tabular_CPD(bnet, B, 'CPT', [0.5 0.5]);

% Define accuracy CPT.
bnet.CPD{A} = tabular_CPD(bnet, A, 'CPT', [0.1 0.04 0.9 0.96]);

% Define time CPT.
bnet.CPD{T} = tabular_CPD(bnet, T, 'CPT', [0.15 0.73 0.12 0.23 0.5 0.27]);

get_field(bnet.CPD{A}, 'cpt')