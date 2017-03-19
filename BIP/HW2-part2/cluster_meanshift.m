function [ output ] = cluster_meanshift( points,radius, threshold )
%   Performs mean shift clustering of given data points
    output = zeros(size(points))*nan;
    is_rgb = size(points,2) == 3;
    for j = 1 : size(points,1)
        if isnan(output(j,1))
            y_list = FindMode(points,j,radius,200);
            dissimilarity = pdist2(points,y_list);
            similar_points = dissimilarity < threshold;
            indices = sum(similar_points,2) ~= 0;
            output(indices,1) = y_list(end,1);
            if is_rgb
                output(indices,2) = y_list(end,2);
                output(indices,3) = y_list(end,3);
            end
            points(indices,:) = nan;
        end
    end
end

