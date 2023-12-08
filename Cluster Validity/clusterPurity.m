function [purity, confMat] = clusterPurity(rowNodes, colNodes)
% Given a computed clustering and a clustering used for labeling purposes,
% computes the purity of the computed clustering with respect to the
% labels.
% Input:
%   rowNodes = The computed clustering nodes. Corresponds to the row labels in the confusion
%              matrix.
%   colNodes = The clustering used for labeling purporses. Corresponds to
%              the column labels in the confusion matrix.
% Output:
%   purity   = The purity of rowNodes vs. colNodes
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

purity = 0;
n = sum(confMat, 'all'); % total number of objects

% Compute total purity of clustering
for i = 1 : rows
    rowN = sum(confMat(i, :));
    rowPurity = 0;
    for j = 1 : cols % cluster purity
        prob = confMat(i, j) / rowN;
        if prob > rowPurity
            rowPurity = prob;
        end
    end
    purity = purity + (rowN/n)*rowPurity;
end

end

