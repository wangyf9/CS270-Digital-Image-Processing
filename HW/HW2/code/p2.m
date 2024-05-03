%pwd
ori_img = imread('..\figure\PET-scan.tif');
[M, N] = size(ori_img);
center_m = ceil(M/2);
center_n = ceil(N/2);
log_img = log(double(ori_img) + 1);
fre_log_img = fft2(log_img);
%set H parameters
r_H = 1;
r_L = 0.1;
c = 1;
D_0 = max(M,N)
H_pass_filter = zeros(M,N);
for u = 1 : M
    for v = 1 : N
        temp = (u-center_m)^2 + (v-center_n)^2;
        H_pass_filter(u, v) = (r_H - r_L) * (1-exp((-c)*(temp/(D_0^2))) + r_L);
    end
end
figure;
subplot(1,4,1);
imshow(H_pass_filter,[]);
title(["Homomorphic Filter with D_0 = ",num2str(D_0)]);
H_pass_filter = fftshift(H_pass_filter);
img_H_res = real(ifft2(fre_log_img.*H_pass_filter));
img_H_res = exp(img_H_res) - 1;
%Normalized
mmax = max(img_H_res(:));
mmin = min(img_H_res(:));
range = mmax-mmin;
res = zeros(M,N);
for i = 1 : M
    for j = 1 : N
        res(i,j) = (img_H_res(i, j)-mmin) / range;
    end
end
%calculate sigma^2
patch = res(500:1100,90:180);
patch_mean = mean(patch(:));
square_diff = (patch - patch_mean).^2;
variance = mean(square_diff(:))
subplot(1,4,2);
imshow(ori_img);
title("Original Image");
subplot(1,4,3);
imshow(res);
title("Homomorphic Filtered image");
subplot(1,4,4);
imshow(patch);
title(["Left white box variance = ",num2str(variance)]);

 