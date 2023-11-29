function sPlot = subgraphPlot(G, sGraph, ttl, sTitle)

figure(); color = hsv(length(sGraph));
sPlot = plot(G, 'NodeLabel', {});
hold on;
title(ttl);
subtitle(sTitle);
for i = 1 : length(sGraph)
    highlight(sPlot, sGraph{i}, 'NodeColor', color(i, :), 'EdgeColor', color(i, :));
end
hold off;

end

