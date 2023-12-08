function sPlot = subgraphPlot(G, sGraph, ttl, sTitle)
% Given a graph and subgraph structures, constructs a graph plot object
% with the subgraphs highlighted.
% Input:
%   G      = Graph object.
%   sGraph = Cell array of subgraphs.
%   ttl    = Plot title object.
%   sTitle = Plot subtitle object.
% Output:
%   sPlot  = Plot object of graph with subgraphs highlighted.

figure('Position', [0, 0, 400, 400]); % size of figure
color = hsv(length(sGraph)); % color family
sPlot = plot(G, 'NodeLabel', {}); % plots graph object
hold on;
title(ttl);
subtitle(sTitle);
% Iteratively highlight the subgraphs
for i = 1 : length(sGraph)
    highlight(sPlot, sGraph{i}, 'NodeColor', color(i, :), 'EdgeColor', color(i, :));
end
hold off;

end

