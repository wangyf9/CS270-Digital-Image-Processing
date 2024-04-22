%pwd
ori_img_grain = imread('..\image\grain.tif');

counts = zeros(1, 256);
[M, N] = size(ori_img_grain);
 
for i = 1: M %traverse
    for j = 1: N
        intensity = ori_img_grain(i, j);
        counts(intensity + 1) = 1 + counts(intensity + 1);
    end
end
bar(0:255, counts);
xlabel("Intensity value");
ylabel("Number of pixels");
title("Histogram of grain");

