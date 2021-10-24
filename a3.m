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
CPT = zeros(2, 2);
CPT(2,2) = 0.96;
CPT(2,1) = 0.04;
CPT(1,2) = 0.9;
CPT(1,1) = 0.1;
bnet.CPD{A} = tabular_CPD(bnet, A, 'CPT', CPT);

% Define time CPT.
CPT = zeros(2, 2, 2, 2);
CPT(2, 2, 1, 1) = 0.15;
CPT(2, 1, 2, 1) = 0.73;
CPT(2, 1, 1, 2) = 0.12;
CPT(1, 2, 1, 1) = 0.23;
CPT(1, 1, 2, 1) = 0.5;
CPT(1, 1, 1, 2) = 0.27;
bnet.CPD{T} = tabular_CPD(bnet, T, 'CPT', CPT);

% Define need help CPT.
CPT = zeros(2, 2);
CPT(2,2) = 0.2;
CPT(2,1) = 0.8;
CPT(1,2) = 0.6;
CPT(1,1) = 0.4;
bnet.CPD{NH} = tabular_CPD(bnet, NH, 'CPT', CPT);

% Define confused CPT.
CPT = zeros(2, 2);
CPT(2,2) = 0.7;
CPT(2,1) = 0.3;
CPT(1,2) = 0.2;
CPT(1,1) = 0.8;
bnet.CPD{C} = tabular_CPD(bnet, C, 'CPT', CPT);

% Create inference engine.
engine = jtree_inf_engine(bnet);

% Define variable for entering evidence.
ev = cell(1,5);

% Determine first probability.
ev{C} = 2;
ev{A} = 2;
ev{T} = 1;
engine = enter_evidence(engine, ev);

marg = marginal_nodes(engine, NH);
fprintf('Marginal probability: %5.3f', marg.T(2));

% Determine second probability.
ev = cell(1, 5);

ev{C} = 1;
ev{A} = 2;
ev{T} = 1;
engine = enter_evidence(engine, ev);

marg = marginal_nodes(engine, NH);
fprintf('Marginal probability: %5.3f', marg.T(2));

