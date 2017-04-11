clc;
clear;
images = {'HW4supplement/malaria_cropped.tif','HW4supplement/prostatecancer_grade4_cropped.tif'};
strelsizes = [10, 3];
medfiltsizes = [7 3];
T = [1,2];
for i = 1 : numel(images)
    I = imread(images{i});
    [~,~,d] = size(I);
    if d > 3
        I = I(:,:,1:3);
    end
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

    %% Segmentation and post processing
    thresholds = multithresh(Iobr,T(i));
    segmented = Iobr < thresholds(1);
    segmented = imopen(segmented,s);
    imshow(segmented);
    title('Segmented image');

    %% Finding markers using distance transform
    D = bwdist(1-segmented,'cityblock');
    I2 = 1 - mat2gray(D);
    fgmarkers = imregionalmin(I2);
    fgmarkers = imdilate(fgmarkers,strel('disk',1));
    imshow(fgmarkers);
    title('Foreground markers');

    %% Overlaying markers
    color = [1 0 0];
    mix = [0.5 0.5];
    im_marked = imoverlay(I,fgmarkers, color, mix);
    imshow(im_marked);
    title('Image with markers');

    %% Background markers
    D = bwdist(segmented);
    L = watershed(D);
    bgmarkers = L == 0;
    imshow(bgmarkers);
    %% Marker controlled watershed transform
    I2 = imimposemin(I2,fgmarkers|bgmarkers);
    imshow(I2);
    L = watershed(I2);
    segmented(L == 0) = 0;
    imshow(segmented);

    Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
    figure
    imshow(Lrgb)
    title('Colored watershed label matrix (Lrgb)')

    CC = bwconncomp(segmented);
    disp('Number of objects');
    CC.NumObjects
    areas =  regionprops(CC,'Area');
    areas = cell2mat(struct2cell(areas));
    histogram(areas,50);
end