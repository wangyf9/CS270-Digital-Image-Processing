%pwd
ori_img_lena = imread('..\image\lena_noisy .tif');

%kernelsize = 3
sigma = 1;
kernel_size = 3;
[M, N] = size(ori_img_lena);
gaussian_kernel = zeros(kernel_size, kernel_size);
gaussian_img_1 = size(M, N);
gaussian_img_2 = size(M, N);
half_patch = (kernel_size - 1)/2;
%Padding so that we can deal with the edge
padded_img = padarray(ori_img_lena, [half_patch, half_patch], 'replicate');
[newM, newN] = size(padded_img);
%generate gaussian kernel
for i = 1: kernel_size
    for j = 1: kernel_size
        x = i - (kernel_size + 1)/2;
        y = j - (kernel_size + 1)/2;
        gaussian_kernel(i, j) = exp(-(x^2 + y^2)/(2 * sigma^2));

    end
end
gaussian_kernel
%Normalized
gaussian_kernel = gaussian_kernel / sum(gaussian_kernel(:));
%Gaussian filter
for i = (1 + half_patch): (newM - half_patch)
    for j = (1 + half_patch): (newN - half_patch)
        patch = double(padded_img((i - half_patch): (i + half_patch), (j - half_patch): (j + half_patch)));
        gaussian_img_1(i - half_patch , j - half_patch) = sum(sum(patch .* gaussian_kernel));
    end
end
%kernelsize = 11
sigma = 1;
kernel_size = 11;
[M, N] = size(ori_img_lena);
gaussian_kernel = zeros(kernel_size, kernel_size);
gaussian_img = size(M, N);
half_patch = (kernel_size - 1)/2;
%Padding so that we can deal with the edge
padded_img = padarray(ori_img_lena, [half_patch, half_patch], 'replicate');
[newM, newN] = size(padded_img);
%generate gaussian kernel
for i = 1: kernel_size
    for j = 1: kernel_size
        x = i - (kernel_size + 1)/2;
        y = j - (kernel_size + 1)/2;
        gaussian_kernel(i, j) = exp(-(x^2 + y^2)/(2 * sigma^2));

    end
end
gaussian_kernel
%Normalized
gaussian_kernel = gaussian_kernel / sum(gaussian_kernel(:));
%Gaussian filter
for i = (1 + half_patch): (newM - half_patch)
    for j = (1 + half_patch): (newN - half_patch)
        patch = double(padded_img((i - half_patch): (i + half_patch), (j - half_patch): (j + half_patch)));
        gaussian_img_2(i - half_patch , j - half_patch) = sum(sum(patch .* gaussian_kernel));
    end
end
%plot
figure;
subplot(1,3,1);
imshow(uint8(gaussian_img_1));
title('kernelsize = 3, Gaussian Filtered Image');
subplot(1,3,2);
imshow(uint8(gaussian_img_2));
title('kernelsize = 11, Gaussian Filtered Image');
subplot(1,3,3);
imshow(ori_img_lena);
title('Original Lena Image');



