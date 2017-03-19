images = {'HW2_TestImages/malaria.tif','HW2_TestImages/lungCT.jpg',...
    'HW2_TestImages/prostatecancer_grade4.tif','HW2_TestImages/prostatecancer_grade4_cropped.tif'};
radii = [10 30; 0.3 0.5; 10 30; 10 30;];
threshold = [5 15; 0.05 0.1;5 15;5 15];

for i = 4:4
    img = imread(images{i});
    img = double(img);
    is_rgb = 0;
    [r,c,d] = size(img);
%     if (r*c > 600*600)
%         img = img(1:400,1:400,:);
%         [r,c,d] = size(img);
%     end
    img = (img - min(img(:)))/(max(img(:)- min(img(:))));
    if(d >= 3)
        img = img(:,:,1:3);
        title('Original image');
        is_rgb = 1;
        img = rgb2lab(img);
        d = 3;
    end   
    for k = 1 : numel(radii(i,:))
        points = reshape(img,r*c,d);
        tic
        output = cluster_meanshift(points,radii(i,k),threshold(i,k));
        toc
        im_name_split = strsplit(images{i},'/');
        im_name = im_name_split(2);
        figure;
        if is_rgb
            result = lab2rgb(reshape(output,r,c,d));
        else
            result = reshape(output,r,c);
        end
        imshow(result);
        title(strcat('Meanshift with R = ', num2str(radii(i,k)),' threshold = ', num2str(threshold(i,k)),' on ', im_name));
        figure;
        if is_rgb
            points = reshape(img,r*c,d);
            result = reshape(result,r*c,d);
            subplot(1,2,1), scatter(points(:,1),points(:,2),10);
            title('Plot of points');
            subplot(1,2,2),scatter(points(:,1),points(:,2),10,result);
            title('Plot of color clusters');
        end
    end
end
