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
bnet.CPD{D} = tabular_CPD(bnet, D, 'CPT', [0.5 0.5]);

% Define accuracy CPT.
bnet.CPD{A} = tabular_CPD(bnet, A, 'CPT', [0.96 0.04 0.9 0.1]);

% Define time CPT.
bnet.CPD{T} = tabular_CPD(bnet, T, 'CPT', [0.15 0.73 0.12 0.23 0.5 0.27]);

% Define need help CPT.
bnet.CPD{NH} = tabular_CPD(bnet, NH, 'CPT', [0.2 0.8 0.6 0.4]);

% Define confused CPT.
bnet.CPD{C} = tabular_CPD(bnet, C, 'CPT', [0.7 0.3 0.2 0.8]);

% Create inference engine.
engine = jtree_inf_engine(bnet);

% Define variable for entering evidence.
ev = cell(1,5);

% Determine first probability.
ev{C} = 2;
ev{A} = 2;
ev{T} = 1;
engine = enter_evidence(engine, ev);

m = marginal_nodes(engine, NH);
fprintf('%5.3f', m.T(2));
