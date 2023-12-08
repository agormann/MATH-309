clear;
rng(2023, "twister")

%% Graph Generation
v = 100;
k = 3;
pInter = 0.75;
pIntra = 0.25;
sizeG = "similar";
rat = [];
maxIter = 25;
[G, gNodes, gPlot] = connectedGraph(v, k, pInter, pIntra, sizeG, rat, maxIter);
exportgraphics(gca, 'graph.png');

%% Component Plot
compPlot = componentPlot(G);
exportgraphics(compPlot, 'comp.png');

%% Naive Fiedler

% Test 1
n1 = 2; tol1 = 0.20;
[sGraphN1, cNodesN1, ~, ~] = naiveFiedler(G, n1, tol1);
formatSpec = "Test 1: n = %d, tol = %.2f";
sTitle = sprintf(formatSpec, n1, tol1);
ttl = "Naive Fiedler Clustering";
sPlotN1 = subgraphPlot(G, sGraphN1, ttl, sTitle);
exportgraphics(gca, 'naive1.png');

%% 
% Test 2
n2 = 4; tol2 = 0.20;
[sGraphN2, cNodesN2, ~, ~] = naiveFiedler(G, n2, tol2);
formatSpec = "Test 2: n = %d, tol = %.2f";
sTitle = sprintf(formatSpec, n2, tol2);
ttl = "Naive Fiedler Clustering";
sPlotN2 = subgraphPlot(G, sGraphN2, ttl, sTitle);
exportgraphics(gca, 'naive2.png');

%% k-means Fiedler

% Test 1
n3 = 1; k1 = 3;
method = 'sample';
metric = 'sqeuclidean';
repeat = 10;
[sGraphK1, cNodesK1] = kmeansFiedler(G, n3, k1, method, metric, repeat);
formatSpec = "Test 1: n = %d, k = %d \n method = '%s', metric = '%s'";
sTitle = sprintf(formatSpec, n3, k1, method, metric);
ttl = "k-means Fiedler Clustering";
sPlotK1 = subgraphPlot(G, sGraphK1, ttl, sTitle);
exportgraphics(gca, 'kmeans1.png');

%%
% Test 2
n4 = 2; k2 = 3;
[sGraphK2, cNodesK2] = kmeansFiedler(G, n4, k2, method, metric, repeat);
formatSpec = "Test 2: n = %d, k = %d \n method = '%s', metric = '%s'";
sTitle = sprintf(formatSpec, n4, k2, method, metric);
ttl = "k-means Fiedler Clustering";
sPlotK2 = subgraphPlot(G, sGraphK2, ttl, sTitle);
exportgraphics(gca, 'kmeans2.png');

%%
close all

%% Cluster Validation

% Accuracy
[accN1, ~] = clusterAccuracy(cNodesN1, gNodes);
% [accN2, ~] = clusterAccuracy(cNodesN2, gNodes);
[accK1, ~] = clusterAccuracy(cNodesK1, gNodes);
[accK2, ~] = clusterAccuracy(cNodesK2, gNodes);
accuracy = [accN1; 0; accK1; accK2];
% Agreement
[aggN1K1, ~] = clusterAccuracy(cNodesN1, cNodesK1);
[aggN1K2, ~] = clusterAccuracy(cNodesN1, cNodesK2);
[aggK1K2, ~] = clusterAccuracy(cNodesK1, cNodesK2);
aggreement = [0 0 aggN1K1 aggN1K2; 0 0 0 0; aggN1K1 0 0 aggK1K2; aggN1K2 0 aggK1K2 0];
% Entropy
[entN1, ~] = clusterEntropy(cNodesN1, gNodes);
[entN2, ~] = clusterEntropy(cNodesN2, gNodes);
[entK1, ~] = clusterEntropy(cNodesK1, gNodes);
[entK2, ~] = clusterEntropy(cNodesK2, gNodes);
entropy = [entN1; entN2; entK1; entK2];
% Purity
[purN1, ~] = clusterPurity(cNodesN1, gNodes);
[purN2, ~] = clusterPurity(cNodesN2, gNodes);
[purK1, ~] = clusterPurity(cNodesK1, gNodes);
[purK2, ~] = clusterPurity(cNodesK2, gNodes);
purity = [purN1; purN2; purK1; purK2];

T = table(accuracy, entropy, purity);
display(T);

T2 = table(aggreement);
display(T2);