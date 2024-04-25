%pwd
ori_img_moon = imread('..\image\moon.jpg');
uint8(20)
Kernel_after_sharpen = [0,-1,0;-1,5,-1;0,-1,0];
[H, W] = size(ori_img_moon);
result = zeros(H, W);
%padding
padded_img = padarray(ori_img_moon, [1, 1], 'replicate');
[newM, newN] = size(padded_img);

for i = 2: (newM - 1)
    for j = 2: (newN - 1)
        patch = double(padded_img((i - 1): (i + 1), (j - 1): (j + 1)));
        result(i - 1, j - 1) = sum(sum(Kernel_after_sharpen .* patch));
    end
end

figure;
imshow(uint8(result));
title('2D Laplacian Convolution Sharpened Image');