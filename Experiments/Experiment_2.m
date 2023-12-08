clear;
rng(309, "twister")

%% Graph Generation
v = 100;
k = 5;
pInter = 0.90;
pIntra = 0.05;
sizeG = "similar";
rat = [];
maxIter = 25;
[G, gNodes, gPlot] = connectedGraph(v, k, pInter, pIntra, sizeG, rat, maxIter);
% exportgraphics(gca, 'graph.png');

%% Component Plot
compPlot = componentPlot(G);
% exportgraphics(compPlot, 'comp.png');

%% Naive Fiedler

% Test 1
n1 = 3; tol = 0.08;
[sGraphN1, cNodesN1, ~, ~] = naiveFiedler(G, n1, tol);
formatSpec = "n = %d, tol = %.2f";
sTitle = sprintf(formatSpec, n1, tol);
ttl = "Naive Fiedler Partitioning";
sPlotN1 = subgraphPlot(G, sGraphN1, ttl, sTitle);
% exportgraphics(gca, 'naive1.png');

% Test 2
n2 = 4; tol = 0.20;
[sGraphN2, cNodesN2, ~, ~] = naiveFiedler(G, n2, tol);
formatSpec = "n = %d, tol = %.2f";
sTitle = sprintf(formatSpec, n2, tol);
ttl = "Naive Fiedler Partitioning";
sPlotN2 = subgraphPlot(G, sGraphN2, ttl, sTitle);
% exportgraphics(gca, 'naive2.png');

%% k-means Fiedler

% Test 1
n3 = 1; k1 = 5;
method = 'plus';
metric = 'sqeuclidean';
repeat = 10;
[sGraphK1, cNodesK1] = kmeansFiedler(G, n3, k1, method, metric, repeat);
formatSpec = "n = %d, k = %d \n method = '%s', metric = '%s'";
sTitle = sprintf(formatSpec, n3, k1, method, metric);
ttl = "k-means Fiedler Partitioning";
sPlotK1 = subgraphPlot(G, sGraphK1, ttl, sTitle);
% exportgraphics(gca, 'kmeans1.png');

% Test 2
n4 = 3; k2 = 5;
[sGraphK2, cNodesK2] = kmeansFiedler(G, n4, k2, method, metric, repeat);
formatSpec = "n = %d, k = %d \n method = '%s', metric = '%s'";
sTitle = sprintf(formatSpec, n4, k2, method, metric);
ttl = "k-means Fiedler Partitioning";
sPlotK2 = subgraphPlot(G, sGraphK2, ttl, sTitle);
% exportgraphics(gca, 'kmeans2.png');

close all
%% Cluster Validation

% Accuracy
[accN1, ~] = clusterAccuracy(cNodesN1, gNodes);
[accN2, ~] = clusterAccuracy(cNodesN2, gNodes);
[accK1, ~] = clusterAccuracy(cNodesK1, gNodes);
[accK2, ~] = clusterAccuracy(cNodesK2, gNodes);
accuracy = [accN1; accN2; accK1; accK2];
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
