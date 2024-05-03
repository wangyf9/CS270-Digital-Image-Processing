%pwd
ori_img = imread('..\figure\blurred.tif');
stand_img = im2double(ori_img);
[M, N] = size(stand_img);
%frequency domain
for i = 1:M
    for j = 1:N
        stand_img(i,j) = stand_img(i,j) * (-1)^(i + j);
    end
end
spectrum2 = log(1 + abs(fft2(stand_img)));
figure;
subplot(1,4,1);
imshow(spectrum2,[]);
title('Original frequency domain image');
%radon transform
theta_range = 1:180;
R = radon(spectrum2, theta_range);
subplot(1,4,2);
imshow(R,[]);
title('Radon transform');
MAX = max(max(R));
[m, n] = find(R == MAX);
%row represents theta
theta = n;
disp(['angle：', num2str(theta), '°']);
%rotate
rotated_img = imrotate(spectrum2, -theta , 'crop');
subplot(1,4,3);
imshow(rotated_img,[]);
title('Rotated frequency domain img');
%Vertical Projection
center_col = M/2;
vertical_projection = sum(rotated_img, 1);
subplot(1,4,4);
plot(vertical_projection);
title('Vertical Projection');
xlabel('Column');
ylabel('Sum');
%find d
[~, locs] = findpeaks(-vertical_projection); 
[~, sorted_idx] = sort(abs(locs - center_col)); 
min_locs = locs(sorted_idx(2:3));
disp(['Left Strip Index:', num2str(min_locs(1))]);
disp(['Right Strip Index:', num2str(min_locs(2))]);
%calculate L
d = (min_locs(2) - min_locs(1))/2;
L = N / d;
disp(['L：', num2str(L)]);