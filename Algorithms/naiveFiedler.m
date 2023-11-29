function [sGraph, cNodes, C, V] = naiveFiedler(G, n, tol)
% Partitions a connected graph into up to 2^n subgraphs by first clustering
% based on sign, and then by euclidean distance between centroids of the
% initially computed clusters.
% Input:
%   G      = Connected graph.
%   n      = Number of eigenvectors of the laplacian matrix to consider.
%   tol    = Distance tolerance between centroids. 
% Output:
%   sGraph = Cell array whose entries are the subgraphs of G.
%   cNodes = Nodes of computed subgraphs.
%   C      = Centroids of computed subgraphs.
%   V      = Row vectors belonging to each subgraph.

gNodes = G.Nodes;  % nodes of full graph
L = laplacian(G);  % graph laplacian
[X, ~] = eigs(L, n+1, 'smallestabs');
eVectors = X(:, 2:n+1); % eigenvectors (columns) as a matrix

negIndices = eVectors < 0; % partition based on sign
basis = unique(negIndices, 'rows'); % unique row vectors as basis
lenBasis = length(basis);

% [Initial Clustering]
% Clusters based on if points in vec have the same sign
initNodes = cell(1, lenBasis);
for i = 1 : lenBasis
    bVectors = basis(i, :); % i-th basis vector
    initNodes{1, i} = find(ismember(negIndices, bVectors, 'rows'));
end

% [Improved Clustering]
% Clusters based on if the centroids are close to within some tolerance
[C, V] = clusterCentroid(eVectors, initNodes); % n-dimensional centroid of each cluster
d = euclideanDist(C); % euclidean distance between centroids
d = d < tol; 
d = triu(d) - diag(diag(d)); % we only want the upper off diagonal

% We convert d into a matrix so as to utilize conncomp(); it makes the
% identification of clusters that are close trivial.
d = d + d'; % converting to adjacency matrix
D = graph(d);
comp = conncomp(D); % connected components
u = unique(comp);   % unique components

% Clustering based on if clusters belong to the same connected component
cNodes = cell(1, length(u));
for i = u
    idx = find(ismember(comp, i)); % finding clusters that have the same comp
    cluster = [];
    for j = 1 : length(idx)
        cluster = [cluster; initNodes{idx(j)}]; % concatenate the clusters
    end
    cNodes{i} = cluster;
end

% [Generating Subgraphs]
numGraphs = length(cNodes);
sGraph = cell(1, numGraphs);

for i = 1 : numGraphs
    subG  = G.subgraph(cNodes{i}); % incomplete subgraph
    edges = subG.Edges;
    sGraph{1, i} = graph(edges, gNodes); % complete subgraph
end

end

