%pwd
ori_img_moon = imread('..\image\moon.jpg');

laplace_kernel_x = [1, -2, 1];
laplace_kernel_y = [1; -2; 1];
[M, N] = size(ori_img_moon);
directionx = zeros(M, N);
directiony = zeros(M, N);

%conv_X
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(ori_img_moon(i, (j - 1): (j + 1)));
        directionx(i, j) = sum(laplace_kernel_x .* patch);
    end
end

%conv_Y
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(ori_img_moon((i - 1): (i + 1), j));
        directiony(i, j) = sum(laplace_kernel_y .* patch);
    end
end
% 显示结果
norm_x = (directionx - min(min(directionx)))/(max(max(directionx)) - min(min(directionx))) *255; 
figure;
subplot(1, 3, 1);
imshow(uint8(norm_x));
title('Laplacian, details in x-direction');
norm_y = (directiony - min(min(directiony)))/(max(max(directiony)) - min(min(directiony))) *255; 
subplot(1, 3, 2);
imshow(uint8(norm_y));
title('Laplacian, details in y-direction');
direction = directionx+directiony;
norm = (direction - min(min(direction)))/(max(max(direction)) - min(min(direction))) *255; 
subplot(1, 3, 3);
imshow(uint8(norm));
title('Laplacian, total details');
