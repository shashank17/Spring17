img = imread('stare-images/im0001.ppm');
img = img(:,:,2);
imshow(img);
sigma = 1.5;
L = 9;
angles = 0:15:180;
w = 5;
im = double(img)/255;
for angle = 0:15:180
    im_match = matched_filter(im, sigma, L, angle);
    mu_H = mean2(im_match);
    im_gauss = fgauss(im, sigma, L, angle);
%     mean_filter = fspecial('average',w);
%     im_gauss = imfilter(im_gauss, mean_filter,'replicate');
    Tc = mu_H*2.3;
    T = (1+im_gauss)*Tc;
    imshow(im_match>T);
    subplot(1,2,1),imshow(im_match);
    subplot(1,2,2), imshow(im_gauss);
end