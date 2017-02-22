images = {'HW2_TestImages/malaria.tif','HW2_TestImages/lungCT.jpg',...
    'HW2_TestImages/prostatecancer_grade4.tif','HW2_TestImages/prostatecancer_grade4_cropped.tif'};

colors = [ 1 0 0; 0 1 0; 0 0 1; 0.5 0.5 0.5];
class_counts = [2 3 3 3];
sigmas = [2 1 1 1];

for i = 1: numel(images)
    img = imread(images{i});
    class_count = class_counts(i);
    if i == 3 || i==4
        img = img(:,:,1:3);
    end
    img = double(img);
    img = (img - min(img(:)))/(max(img(:)) - min(img(:)));
%     if i ~=2
%         img = rgb2gray(img);
%     end
    subplot(1,2,1),imshow(img);
    title('Original image');
    filtered = imgaussfilt(img,sigmas(i));
    subplot(1,2,2),imshow(filtered);
    title('Filtered image');
    [rows, columns, channels] = size(img);
    vectr_img = reshape(filtered,rows*columns,channels);
    idx = kmeans(vectr_img,class_count);
    output = zeros(size(idx,1),3);
    for j = 1: class_count
        color = colors(j,:);
        x = find(idx == j);
        for k = 1: numel(x)
            output(x(k),:) = color;
        end
    end
    subplot(1,2,2),imshow((reshape(output,rows,columns,3)));
    title('K-means clustering result');
end


