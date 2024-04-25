%pwd
ori_img = imread('..\figure\Figure1.tif');

%def sobel operator
sobel_extract_horizontal = [-1,0,1;-2,0,2;-1,0,1];
sobel_extract_vertical = [-1,-2,-1;0,0,0;1,2,1];

%padding
padding_img = padarray(ori_img, [1, 1], 'replicate');
[M, N] = size(padding_img);
vertical_res = zeros(M,N);
horizontal_res = zeros(M,N);
total = zeros(M,N);
%conv_vertical
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(padding_img((i - 1): (i + 1), (j - 1): (j + 1)));
        vertical_res(i, j) = sum(sum(sobel_extract_vertical .* patch));
    end
end

%conv_horizontal
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(padding_img((i - 1): (i + 1), (j - 1): (j + 1)));
        horizontal_res(i, j) = sum(sum(sobel_extract_horizontal .* patch));
    end
end
for i = 1: M
    for j = 1:N
        total(i,j) = sqrt(vertical_res(i, j)^2 +  horizontal_res(i, j)^2);
    end
end

figure;
subplot(1, 3, 1);
imshow(uint8(vertical_res));
title("Sobel, details in vertical-direction");
subplot(1, 3, 2);
imshow(uint8(horizontal_res));
title("Sobel, details in horizontal-direction");
subplot(1, 3, 3);
imshow(uint8(total));
title("Sobel, total details");

