function specPlot = spectralDrawing(C, V, ttl, sTitle)
% Given a 2 or 3-dimensional set of vectors and centroids, constructs the
% spectral drawing. 
% Input:
%   C        = Cell array of centroids.
%   V        = Cell array of matrices who members are row vectors.
%   ttl      = Plot title object.
%   sTitle   = Plot subtitle object.
% Output:
%   specPlot = Spectral drawing plot object.

len = length(C);

test = C{1}; % centroid must be dim 2 or 3.
if length(test) == 2
    specPlot = figure;
    hold on;
    xlabel('x_1'); ylabel('x_2');
    title(ttl); subtitle(sTitle);
    color = hsv(len); % color family
    % iteratively plot centroids and associated vectors
    for i = 1 : len
        plot(C{i}(1), C{i}(2), 'Color', 'black', 'Marker', 'x', 'MarkerSize', 10);
        plot(V{i}(:, 1), V{i}(:, 2), 'LineStyle', 'none', 'Marker', '.', 'Color', color(i, :))
    end
    hold off;
elseif length(test) == 3
    specPlot = figure;
    hold on;
    view(3); xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
    title(ttl); subtitle(sTitle);
    color = hsv(len);
    for i = 1 : len
        plot3(C{i}(1), C{i}(2), C{i}(3), 'Color', 'black', 'Marker', 'x', 'MarkerSize', 10);
        plot3(V{i}(:, 1), V{i}(:, 2), V{i}(:, 3), 'LineStyle', 'none', 'Marker', '.', 'Color', color(i, :))
    end
    hold off;
else
    error("Vectors must be either 2 or 3-dimensional.")
end

end

