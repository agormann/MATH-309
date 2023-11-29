function [purity, confMat] = clusterPurity(rowNodes, colNodes)

rows = length(rowNodes);
cols = length(colNodes);

confMat = zeros(rows, cols);
for i = 1 : rows
    for j = 1 : cols
        s = intersect(rowNodes{i}, colNodes{j});
        confMat(i, j) = length(s);
    end
end

purity = 0;
n = sum(confMat, 'all');

for i = 1 : rows
    rowN = sum(confMat(i, :));
    rowPurity = 0;
    for j = 1 : cols
        prob = confMat(i, j) / rowN;
        if prob > rowPurity
            rowPurity = prob;
        end
    end
    purity = purity + (rowN/n)*rowPurity;
end

end

