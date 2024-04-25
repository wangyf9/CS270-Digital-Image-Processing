%pwd
ori_img = imread('..\figure\blurred.tif');
stand_img = im2double(ori_img);
[M, N] = size(stand_img);

spectrum2 = log(1 + abs(fftshift(fft2(stand_img))));
figure;
subplot(1,5,1);
imshow(spectrum2,[]);
theta_range = 1:180;
R = radon(spectrum2, theta_range);

subplot(1,5,2);
imshow(R,[]);
MAX = max(max(R));
[m, n] = find(R == MAX);
theta = m*180/M;
disp(['max col：', num2str(m)]);
disp(['max row：', num2str(n)]);
disp(['angle：', num2str(theta), '°']);

rotated_img = imrotate(spectrum2, -theta + 3.5, 'crop');
subplot(1,5,3);
imshow(rotated_img,[]);
center_col = M/2;
vertical_projection = sum(rotated_img, 1);
[~, locs] = findpeaks(-vertical_projection); % 使用负值进行查找，找到谷值
[~, sorted_idx] = sort(abs(locs - center_col)); % 按距离中心列的距离排序
min_locs = locs(sorted_idx(3:4)); % 找到距离中心最近的两个极小值点的索引

disp(['左侧极小值点索引：', num2str(min_locs(1))]);
disp(['右侧极小值点索引：', num2str(min_locs(2))]);
% 显示垂直投影图像
subplot(1,5,4);
plot(vertical_projection);
title('Vertical Projection');
xlabel('Column');
ylabel('Sum');
d = (min_locs(2) - min_locs(1))/2;
L = N / d;
disp(['L：', num2str(L)]);
subplot(1,5,5);
PSF = fspecial('motion',10, 120);
wnr1 = deconvwnr(ori_img, PSF);
imshow(wnr1,[]);
title('Restored Image');