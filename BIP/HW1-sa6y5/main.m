img = imread('test-images/3TS0007.tif');
mask = imread('test-images/mask.tif');

% Histogram of the whole image
% [H, edges] = myhist(img);

% Histogram of the masked image
[H,edges] = myhist(img,256,mask);
stem(edges,H,'Marker', 'none');


%% Linear contrast stretching

% img2 = mycontraststrch(img,0.05);
% subplot(1,2,1),imshow(img);
% title('Original Image');
% subplot(1,2,2),imshow(img2);
% title('Contrast Enhanced Image');
% figure; histogram(img2);