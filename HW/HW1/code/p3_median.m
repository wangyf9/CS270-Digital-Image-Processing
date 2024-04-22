%pwd
ori_img_lena = imread('..\image\lena_noisy .tif');

%kernelsize = 3
kernel_size = 3;
half_patch = (kernel_size - 1)/2;
[M, N] = size(ori_img_lena);
median_img_1 = size(M, N);
median_img_2 = size(M, N);
%Padding so that we can deal with the edge
padded_img = padarray(ori_img_lena, [half_patch, half_patch], 'replicate');
[newM, newN] = size(padded_img);
%Median filter
for i = (1 + half_patch): (newM - half_patch)
    for j = (1 + half_patch): (newN - half_patch)
        patch = double(padded_img((i - half_patch): (i + half_patch), (j - half_patch): (j + half_patch)));
        new_patch = transpose(patch(:));
        mid = median(new_patch);
        median_img_1(i - half_patch , j - half_patch) = mid;
    end
end
%kernelsize = 7
sigma = 1;
kernel_size = 7;
half_patch = (kernel_size - 1)/2;
[M, N] = size(ori_img_lena);
median_img = size(M, N);
%Padding so that we can deal with the edge
padded_img = padarray(ori_img_lena, [half_patch, half_patch], 'replicate');
[newM, newN] = size(padded_img);
%Median filter
for i = (1 + half_patch): (newM - half_patch)
    for j = (1 + half_patch): (newN - half_patch)
        patch = double(padded_img((i - half_patch): (i + half_patch), (j - half_patch): (j + half_patch)));
        new_patch = transpose(patch(:));
        mid = median(new_patch);
        median_img_2(i - half_patch , j - half_patch) = mid;
    end
end
subplot(1,3,1);
imshow(uint8(median_img_1));
title('kernelsize = 3, Median Filtered Image');
subplot(1,3,2);
imshow(uint8(median_img_2));
title('kernelsize = 7, Median Filtered Image');
subplot(1,3,3);
imshow(ori_img_lena);
title('Original Lena Image');
