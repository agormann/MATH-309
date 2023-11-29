function d = euclideanDist(C)
% Computes the euclidean distance between centroids and stores it as an
% upper triangular matrix.
% Input:
%   C = Cell array of centroids.
% Output:
%   d = Upper triangular matrix of euclidean distances between centroids.

len = length(C);
d = zeros(len, len);
for i = 1 : len
    for j = i+1 : len % ignore case when i = j
        d(i, j) = sum((C{i} - C{j}).^2).^0.5; % euclidean distance
    end
end

end