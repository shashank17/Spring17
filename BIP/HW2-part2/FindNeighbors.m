function [ Nlist ] = FindNeighbors( data, y, R)
%   Finds the neighbors of a given data points that are with in a distance
%   of R
dists = pdist2(data,y);
Nlist = dists < R;
end

