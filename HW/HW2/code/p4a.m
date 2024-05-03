%pwd
ori_img = imread('..\figure\blurred.tif');
stand_img = im2double(ori_img);
[M, N] = size(stand_img);
% fftshift corresponding in spatial area
for i = 1:M
    for j = 1:N
        stand_img(i,j) = stand_img(i,j) * (-1)^(i + j);
    end
end
spectrum2 = log(1 + abs(fft2(stand_img)));
figure;
imshow(spectrum2,[]);
title('Logarithmic Spectrum of Image');