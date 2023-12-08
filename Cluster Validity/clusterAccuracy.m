function [accuracy, confMat] = clusterAccuracy(rowNodes, colNodes)
% Given a true clustering and a computed clustering, returns the accuracy
% of the computed clustering as well as the associated confusion matrix. If
% instead the two clusterings are both computed clusterings, then it
% returns the agreement.
% Input:
%   rowNodes = The computed clustering nodes. Corresponds to the row labels in the confusion
%              matrix.
%   colNodes = The true clustering (or a secondary computed clustering.
%              Corresponds to the column labels in the confusion matrix.
% Output:
%   accuracy = The accuracy (or agreement) of rowNodes vs. colNodes.
%   confMat  = Confusion matrix where rowNodes are the row labels, and
%              colNodes are the column labels.

% Sanity check
len = length(rowNodes);
if len ~= length(colNodes)
    error('The dimensions of the input arrays do not match.')
end

% Constructing the confusion matrix
confMat = zeros(len);
for i = 1 : len
    for j = 1 : len
        s = intersect(rowNodes{i}, colNodes{j});
        confMat(i, j) = length(s);
    end
end

% Solves the linear assignment problem
M = matchpairs(confMat, 0.10, 'max');

% Computing number of correct labels
correct = 0;
for i = 1 : len
    correct = correct + confMat(M(i, 1), M(i, 2));
end

% Accuracy (or agreement)
total = sum(confMat, 'all');
accuracy = correct/total;

end

