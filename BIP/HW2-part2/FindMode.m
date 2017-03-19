function [ y_list ] = FindMode( data, ind, R, max_iter )
%   Find the peaks in feature space though repeated mean shift
y = data(ind,:);
i = 1;
prev_y = ones(size(y))*nan;
current_y = y;
y_list= zeros(max_iter,size(y,2))*nan;
y_list(1,:) = y;

while i < max_iter && ~(norm(current_y - prev_y) < 0.01)
    prev_y = current_y;
    isneighbor = FindNeighbors(data,current_y,R);
    current_y = Neighbors2Mean(data,isneighbor,current_y);
    i = i + 1;
    y_list(i,:) = current_y;
end
y_list = y_list(~isnan(y_list(:,1)),:);
end

