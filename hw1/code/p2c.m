%pwd
ori_img_moon = imread('..\image\moon.jpg');
double_ori_img_1 = double(ori_img_moon);
[M, N] = size(ori_img_moon);
smoothed_img = zeros(M, N);
%padding
padded_img = padarray(ori_img_moon, [1, 1], 'replicate');
[newM, newN] = size(padded_img);
double_ori_img_2 = double(padded_img);
%get smooth image
for i = 2: (newM - 1)
    for j = 2: (newN - 1)
        smoothed_img(i - 1, j - 1) = sum(sum(double_ori_img_2((i-1):(i+1), (j-1):(j+1))))/9;
    end
end
%get high frenquency information
g_mask = double_ori_img_1 - smoothed_img;
%sharpen image
g_1 = double_ori_img_1 + 1 * g_mask;
subplot(1,4,1);
imshow(uint8(g_1));
title("K = 1, Unsharpen Mask sharpens result");
g_2 = double_ori_img_1 + 3 * g_mask;
subplot(1,4,2);
imshow(uint8(g_2));
title("K = 3, Unsharpen Mask sharpens result");
g_3 = double_ori_img_1 + 5 * g_mask;
subplot(1,4,3);
imshow(uint8(g_3));
title("K = 5, Unsharpen Mask sharpens result");
subplot(1,4,4);
imshow(ori_img_moon);
title("Origin image");
