function [entropy, confMat] = clusterEntropy(rowNodes, colNodes)

rows = length(rowNodes);
cols = length(colNodes);

confMat = zeros(rows, cols);
for i = 1 : rows
    for j = 1 : cols
        s = intersect(rowNodes{i}, colNodes{j});
        confMat(i, j) = length(s);
    end
end

entropy = 0;
n = sum(confMat, 'all');

for i = 1 : rows
    rowN = sum(confMat(i, :));
    rowEntropy = 0;
    for j = 1 : cols
        prob = confMat(i, j) / rowN;
        if prob ~= 0
            rowEntropy = rowEntropy + prob*log2(prob);
        end
    end
    entropy = entropy -(rowN/n)*rowEntropy;
end

end

