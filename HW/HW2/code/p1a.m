%pwd
ori_img = imread('..\figure\Figure1.tif');
double_ori = double(ori_img);
[m,n] = size(ori_img);
figure;
subplot(2, 3, 1);
imshow(ori_img);
title("Original Image");
%def sobel operator
sobel_extract_horizontal_1 = [1;2;1];
sobel_extract_horizontal_2 = [-1,0,1];
sobel_extract_vertical_1 = [-1;0;1];
sobel_extract_vertical_2 = [1,2,1];
%padding
padding_img = padarray(ori_img, [1, 1], 'replicate');
[M, N] = size(padding_img);
vertical_res_1 = zeros(M,N);
vertical_res_2 = zeros(M,N);
horizontal_res_1 = zeros(M,N);
horizontal_res_2 = zeros(M,N);
total = zeros(m,n);
%conv_vertical_1
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(padding_img((i - 1): (i + 1), j));
        vertical_res_1(i, j) = sum(sobel_extract_vertical_1 .* patch);
    end
end
subplot(2, 3, 2);
imshow(uint8(vertical_res_1));
title("Sobel, First conv details in vertical-direction");

%conv_vertical_2
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(vertical_res_1(i, (j - 1): (j + 1)));
        vertical_res_2(i, j) = sum(sobel_extract_vertical_2 .* patch);
    end
end
subplot(2, 3, 3);
imshow(uint8(vertical_res_2));
title("Sobel, Second conv details in vertical-direction");

%conv_horizontal_1
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(padding_img(i, (j - 1): (j + 1)));
        horizontal_res_1(i, j) = sum(sobel_extract_horizontal_2 .* patch);
    end
end
subplot(2, 3, 4);
imshow(uint8(horizontal_res_1));
title("Sobel, First conv details in horizontal-direction");

%conv_horizontal_2
for i = 2: (M - 1)
    for j = 2: (N - 1)
        patch = double(horizontal_res_1((i - 1): (i + 1), j));
        horizontal_res_2(i, j) = sum(sobel_extract_horizontal_1 .* patch);
    end
end
subplot(2, 3, 5);
imshow(uint8(horizontal_res_2));
title("Sobel, Second conv details in horizontal-direction");
for i = 1: m
    for j = 1:n
        %total(i,j) = sqrt(vertical_res(i, j)^2 +  horizontal_res(i, j)^2);
        total(i,j) = abs(vertical_res_2(i, j)) +  abs(horizontal_res_2(i, j));
    end
end
sharpened_img = double_ori + 0.5*total;
subplot(2, 3, 6);
imshow(uint8(total));
title("Sobel, total details");
figure;
imshow(uint8(sharpened_img));
title("Sharpened image");

