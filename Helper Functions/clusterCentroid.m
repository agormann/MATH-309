function [C, V] = clusterCentroid(eVectors, cNodes)
% Computes the centroids of the clusters by viewing the concatenated 
% eigenvectors as a matrix of row vectors.
% Input:
%   eVectors = Matrix of eigenvectors (column) of the graph laplacian.
%   cNodes   = Cell array of clusters (subgraphs) nodes.
% Output:
%   C        = Cell array of centroids of the clusters.
%   V        = Cell array of row vectors in the clusters (for plot).

len = length(cNodes);
C = cell(1, len);
V = cell(1, len);

for i = 1 : len
    v = eVectors(cNodes{i}, :); % vectors in i-th cluster
    sz = size(eVectors, 2);     % dimension of vectors
    m = zeros(1, sz);
    for j = 1 : sz
        m(j) = mean(v(:, j)); % centroid of vectors
    end
    C{i} = m;
    V{i} = v;
end

end

