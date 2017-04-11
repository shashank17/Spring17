clc;
clear;
images = {'HW4supplement/malaria_cropped.tif','HW4supplement/prostatecancer_grade4_cropped.tif'};
strelsizes = [10, 3];
medfiltsizes = [7 3];
sigmas = [15, 5.5];
T = [1,2];
for i = 2 : numel(images)
    I = imread(images{i});
    [~,~,d] = size(I);
    if d > 3
        I = I(:,:,1:3);
    end
    imshow(I)
    title('Original image');
    %% preprocessing
    img = rgb2gray(I);
    imshow(img);
    title('Original Image');
    w = medfiltsizes(i);
    img = medfilt2(img,[w w]);
    r = strelsizes(i);
    s = strel('disk',r);
    Ie = imerode(img,s);
    Iobr = imreconstruct(Ie, img);
    imshow(Iobr);
    title('Filtered image');
    
    sigma = sigmas(i);
    log = fspecial('log',[6*sigma+1 6*sigma+1],sigma);
    log = log*sigma*sigma;
    filtered = imfilter(Iobr, log, 'replicate');
    fgmarkers = imregionalmax(filtered);
    imshow(fgmarkers);
    title('Foreground markers');
    
    fgmarkers = imdilate(fgmarkers,strel('disk',1));
    color = [1 0 0];
    mix = [0.5 0.5];
    im_marked = imoverlay(I,fgmarkers, color, mix);
    imshow(im_marked);
    title('Image with markers');

    I2 = imimposemin(imcomplement(Iobr), fgmarkers);
    L = watershed(I2);

    Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
    figure
    imshow(Lrgb)
    title('Colored watershed label matrix (Lrgb)')

end