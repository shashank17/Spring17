function[result]= local_mean(I,w)
%   Performs mean filtering of image I with the window size w
result = I;
[r,c] = size(I);
if numel(w) == 1
    vert_step = floor(w/2);
    horiz_step = floor(w/2);
    wh = w;
    wv = w;
else
    vert_step = floor(w(1)/2);
    horiz_step = floor(w(2)/2);
    wh = w(1);
    wv = w(2);
end

for i = vert_step+1 : r - vert_step
    top = i-vert_step;
    bottom = i+vert_step;
    for j = horiz_step+1 : c - horiz_step
        left = j- horiz_step;
        right = j+ horiz_step;
        subimg = I(top:bottom, left:right);
        result(i,j) = sum(subimg(:))/(wh*wv);
    end
end
end
