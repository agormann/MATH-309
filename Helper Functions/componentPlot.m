function tiledPlot = componentPlot(G)
% Returns a tiledlayout plot structure of the entries of the 4 smallest
% eigenvectors of a graph G (excluding the trivial eigenvector).
% The entries in the eigenvector X1 are sorted in ascending order, and the
% entries in eigenvectors X2, X3, X4 are sorted according to X1.
% Input:
%   G         = graph data structure.
% Output:
%   tiledPlot = tiledlayout plot structure.

h = height(G.Nodes); % x-axis for plots
L = laplacian(G);    % graph laplacian to extract eigenvectors

[X, ~] = eigs(L, 5, 'smallestabs');
vec = X(:, 2:end);   % ignore X1
[~, I] = sort(vec(:, 1), 'ascend'); % sort according to X1
vec = vec(I, :);
x = 1:h;

% tiledplot structure
figure('Position', [0, 0, 800, 600]);
tiledPlot = tiledlayout(2, 2, "TileSpacing", "compact", "Padding", "compact");
title(tiledPlot, {"Components of x_i", "Sorted According to x_1"})
xlabel(tiledPlot, "Sorted Component"); ylabel(tiledPlot, "Magnitude");

t1 = nexttile(); % X1 plot
plot(x, vec(:, 1), '.-');
title(t1, "Components of x_1");
yline(t1, 0, '--');
xlim(t1, [0 h]);

t2 = nexttile; % X2 plot
plot(x, vec(:, 2), '.-');
title(t2, "Components of x_2");
yline(t2, 0, '--');
xlim(t2, [0 h]);

t3 = nexttile; % X3 plot
plot(x, vec(:, 3), '.-');
title(t3, "Components of x_3");
yline(t3, 0, '--');
xlim(t3, [0 h]);

t4 = nexttile; % X4 plot
plot(x, vec(:, 4), '.-');
title(t4, "Components of x_4");
yline(t4, 0, '--');
xlim(t4, [0 h]);

end

