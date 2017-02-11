function [ h,binedges ] = myhist( I,nbins, mask )
%   Calculates the histogram of an image
    if nargin < 2
        nbins = 256;
    end
    if nargin < 3
        mask = true(size(I));
    else
        mask = logical(mask);
    end
    binedges = linspace(0,255,nbins);
    maskedImg = I(mask);
    h = zeros(1,nbins);
    for i = 1: numel(binedges)-1
        h(i) = size(find(maskedImg >= binedges(i) & maskedImg < binedges(i+1)),1);
        if i == numel(binedges)-1
            h(i) = size(find(maskedImg >= binedges(i) & maskedImg <= binedges(i+1)),1);
        end
    end
end

