function [accuracy, confMat] = clusterAccuracy(rowNodes, colNodes)

len = length(rowNodes);
if len ~= length(colNodes)
    error('The dimensions of the input arrays do not match.')
end

confMat = zeros(len);
for i = 1 : len
    for j = 1 : len
        s = intersect(rowNodes{i}, colNodes{j});
        confMat(i, j) = length(s);
    end
end

M = matchpairs(confMat, 0.10, 'max');

correct = 0;
for i = 1 : len
    correct = correct + confMat(M(i, 1), M(i, 2));
end

total = sum(confMat, 'all');
accuracy = correct/total;

end

