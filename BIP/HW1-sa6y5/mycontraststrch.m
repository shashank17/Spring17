function [ I ] = mycontraststrch( img,leaveout )
%UNTITLED4 Summary of this function goes here
%   Performs linear contrast enhacement of the img,
%   leaveout option specifies the percentage of pixels to discard
if nargin == 2
    [counts,locs] = imhist(img,255);
    csum = cumsum(counts);
    [rows, columns] = size(img);
    totalPixels = rows*columns;

    minIndex = find(csum > totalPixels*leaveout,1);
    maxIndex = find(csum > totalPixels*(1-leaveout),1);
    if minIndex == 1
        minIntensity = locs(1);
    else
        minIntensity = locs(minIndex - 1);
    end
    maxIntensity = locs(maxIndex);
    img(img < minIntensity) = minIntensity;
    img(img > maxIntensity) = maxIntensity;
end
img = double(img);
I = (img - min(img(:)))./(max(img(:)) - min(img(:)));
I = uint8(I*255);
end

