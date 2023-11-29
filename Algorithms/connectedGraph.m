function [G, gNodes, gPlot] = connectedGraph(v, k, pInter, pIntra, sizeG, rat, maxIter)
% Generates a connected graph of v vertices with k subgraphs.
% Input:
%   v       = Number of vertices.
%   k       = Number of subgraphs.
%   pInter  = Probability of having an edge connection between two vertices
%             in the same subgraph.
%             Either a single value or a vector with k values. The i-th
%             entry in the vector corresponds to the i-th subgraph.
%   pIntra  = Probability of having an edge connection between two
%             vertices in different subgraphs.
%             Either a single value or a vector with k-1 values. The
%             reason for k-1 is that a graph cannot connect to itself.
%   sizeG   = "similar" : subgraph sizes as equal as possible.
%             "ratio"   : subgraph sizes are based on the decimal ratios 
%                         provided in r.
%   rat     = Vector with k values. Each entry must be a decimal in [0, 1]
%             and sum(rat) must equal 1. If using "similar", then set rat = [].
%   maxIter = Max number of iterations when generating the graph G.
% Output:
%   G       = Connected graph in sparse format.
%   gNodes  = Nodes of subgraphs of G (for validation).
%   gPlot   = Plot of graph structure.

% [Subgraph Sizes]
if sizeG == "similar"
    q = floor(v/k);      % Find largest # of vectors that can be cleanly divvied up
    r = v - k*q;
    s = repelem(q, k);
    s(1:r) = s(1:r) + 1; % Sprinkle leftovers
elseif sizeG == "ratio"
    s = floor(rat*v);    % Find integer sizes that are closest to the ratios
    r = v - sum(s);
    s(1:r) = s(1:r) + 1; % Sprinkle leftovers
else
    error("sizeG parameter input incorrectly.")
end

% x = randperm(v); % Randomly permuting the vertices
x = 1:v; x = x';
A = zeros(v, v); % Preallocating adjacency matrix

% [Creating Subgraphs]
parts = cumsum(s); % Indices for subgraph 'splitting points'
gNodes = cell(1, k); % Preallocation
gNodes{1} = x(1 : parts(1));       % First subgraph
for i = 2 : k-1                    % Middle subgraphs
    gNodes{i} = x(parts(i-1)+1 : parts(i)); % Add 1 to prevent repetition
end
gNodes{k} = x(parts(k-1)+1 : end); % Last subgraph

% [Handling Probabilities]
if isscalar(pInter)
    p = pInter;
    pInter = repmat(p, 1, k);
end
if isscalar(pIntra)
    p = pIntra;
    pIntra = repmat(p, 1, k-1);
end

% [Graph Generation]
% The graph produced can have several connected components, so we iterate
% until a connected graph is produced.
flag = true;
iter = 0;
while flag || iter <= maxIter
    for i = 1 : k
        % Random edges between vertices in the same cluster
        A(gNodes{i}, gNodes{i}) = rand(s(i), s(i)) < pInter(i);
        for j = i+1 : k
            % Random edges between vertices in different clusters
            A(gNodes{i}, gNodes{j}) = rand(s(i), s(j)) < pIntra(j-1);
        end
    end
    
    A = triu(A, 1); % Upper triangular part of A
    A = A + A';     % Making A symmetric

    con = sum(conncomp(graph(A))); % Sum of connected components
    if con == v     % Each vertex should be in the same connection
        flag = false;
    elseif iter == maxIter
        error("Max # of iterations reached. Please choose better probabilities.")
    end
    iter = iter + 1;
end

vLabel = arrayfun(@num2str, x, 'UniformOutput', 0); % Label the vertices
G = graph(A, vLabel); % Construct graph object

% [Plotting]
figure();
gPlot = plot(G, 'NodeLabel', {});
hold on;
formatSpec = "v = %d, k = %d, pInter = %.2f, pIntra = %.2f, sizeG = %s";
sTitle = sprintf(formatSpec, v, k, pInter(1), pIntra(1), sizeG);
ttl = "Connected Graph";
title(ttl);
subtitle(sTitle);
hold off;

end

