function [ y_next ] = Neighbors2Mean( data, Nlist, y)
%   Given neighbors indices, this method calculates the weighted mean of a
%   neighborhood
neighbors = data(Nlist,:);
[~,columns] = size(y);
weights = exp(-0.5*pdist2(neighbors,y));
sum(weights);

y_next = sum(repmat(weights,1,columns).*neighbors,1)/sum(weights(:));
end

