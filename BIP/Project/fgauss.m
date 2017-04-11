function [ result ] = fgauss(img, sigma, L, angle)
% Performs convolution with first order derivative of gaussian

matchrow = floor(L/2);
x = -3*sigma : 3* sigma;
y = (-x/(sqrt(2*pi*sigma^3))).*exp(-(x.^2)/(2*sigma^2));
fdogfilter =  repmat(y,[matchrow*2+1, 1]);
m = sum(fdogfilter(:))/numel(fdogfilter);
fdogfilter = -fdogfilter + m;
imshow(fdogfilter);
filtr = imrotate(fdogfilter,angle);
result =  imfilter(img,filtr,'replicate');

end

