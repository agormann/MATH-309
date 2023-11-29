function [sGraph, cNodes] = kmeansFiedler(G, n, k, method, metric, repeat)
% Partitions a connected graph into k subgraphs using n eigenvectors,
% via k-means.
% Input:
%   G      = Connected graph.
%   n      = Number of eigenvectors of the laplacian matrix to consider.
%   k      = Number of subgraphs.
%   method = Method for choosing initial cluster centroid positions.
%   metric = Distance metric for kmeans.
%   repeat = Number of times to repeat the k-means process.
% Output:
%   sGraph = Cell array whose entries are the subgraphs of G.
%   cNodes = Nodes of computed subgraphs.

gNodes = G.Nodes;       % nodes of full graph
L      = laplacian(G);  % graph laplacian
[X, ~] = eigs(L, n+1, 'smallestabs');
eVectors   = X(:, n+1); % eigenvectors

[idx, ~] = kmeans(eVectors, k, 'Start', method,  'Distance', metric, ...  % computes centroids
           'Replicates', repeat, 'EmptyAction', "error");

sGraph = cell(1, k); % preallocating
cNodes = cell(1, k);

for i = 1 : k
    index = idx == i;          % i-th cluster
    nodes = find(index);       % nodes corresponding to indices
    cNodes{1, i} = nodes;      % storing nodes for validation
    subG  = G.subgraph(nodes); % incomplete subgraph
    edges = subG.Edges;
    sGraph{1, i} = graph(edges, gNodes); % complete subgraph
end

end

