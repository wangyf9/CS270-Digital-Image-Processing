image = imread('../figure/flower.tif');
gray_image = rgb2gray(image);
%Normalize
gray_image = im2double(gray_image);
%Iterative
T_new = 0;
T = 0.1;
while true
    foreground = gray_image(gray_image > T);
    background = gray_image(gray_image <= T);
    mean_foreground = mean(foreground(:));
    mean_background = mean(background(:));
    T_new = 0.5 * (mean_foreground + mean_background);
    if abs(T_new - T) < 0.001
        break;
    end
    T = T_new;
end
%Threshold
foreground = gray_image > T;
background = gray_image <= T;
figure;
subplot(1, 3, 1);
imshow(gray_image);
title('Original Image');
subplot(1, 3, 2);
imshow(foreground);
title(['foreground of Image using Global Thresholding, T =',num2str(T)]);
subplot(1, 3, 3);
imshow(background);
title(['background of Image using Global Thresholding, T =',num2str(T)]);

