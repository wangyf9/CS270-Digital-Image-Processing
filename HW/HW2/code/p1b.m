%pwd
ori_img = imread('..\figure\Figure1.tif');

%def gaussian highpass filter
D_0 = 100;
[M, N] = size(ori_img);
center_m = ceil(M/2);
center_n = ceil(N/2);
H_gaussian = zeros(M,N);
for i = 1:M
    for j = 1:N
        D = ((i - center_m)^2 + (j - center_n)^2);
        H_gaussian(i,j) = 1 - exp((-D) / (2*(D_0^2)));
    end
end

%get image frequency domain
fre_img = fftshift(fft2(double(ori_img)));
%get result
img_H_res = uint8(real(ifft2(ifftshift(fre_img.*H_gaussian))));
figure;
subplot(1,3,1);
imshow(ori_img);
title("Original Image");
subplot(1,3,2);
imshow(H_gaussian,[]);
title("Highpass Gaussian filter");
subplot(1,3,3);
imshow(img_H_res);
title("Highpass Gaussian filtered image");


