function [entropy, confMat] = clusterEntropy(rowNodes, colNodes)
% Given a computed clustering and a clustering used for labeling purposes,
% computes the entropy of the computed clustering with respect to the
% labels.
% Input:
%   rowNodes = The computed clustering nodes. Corresponds to the row labels in the confusion
%              matrix.
%   colNodes = The clustering used for labeling purporses. Corresponds to
%              the column labels in the confusion matrix.
% Output:
%   entropy  = The entropy of rowNodes vs. colNodes
%   confMat  = Confusion matrix where rowNodes are the row labels, and
%              colNodes are the column labels.

rows = length(rowNodes);
cols = length(colNodes);

% Constructing the confusion matrix
confMat = zeros(rows, cols);
for i = 1 : rows
    for j = 1 : cols
        s = intersect(rowNodes{i}, colNodes{j});
        confMat(i, j) = length(s);
    end
end

entropy = 0;
n = sum(confMat, 'all'); % total number of objects

% Compute total entropy of clustering
for i = 1 : rows
    rowN = sum(confMat(i, :));
    rowEntropy = 0;
    for j = 1 : cols % cluster entropy
        prob = confMat(i, j) / rowN;
        if prob ~= 0
            rowEntropy = rowEntropy + prob*log2(prob); 
        end
    end
    entropy = entropy -(rowN/n)*rowEntropy;
end

end

