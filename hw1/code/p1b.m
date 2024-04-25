%pwd
ori_img_grain = imread('..\image\grain.tif');

counts = zeros(1, 256);
[M, N] = size(ori_img_grain);
%Histogram
for i = 1: M %traverse
    for j = 1: N
        intensity = ori_img_grain(i, j);
        counts(intensity + 1) = 1 + counts(intensity + 1); %count
    end
end
%Normalized Histogram
Normalized_hist = counts / (M* N); %Normalize
Cdf = zeros(1, 256);
Cdf(1) = Normalized_hist(1);
for i = 2: 256
    Cdf(i) = Cdf(i-1) + Normalized_hist(i);  %Accumulate
end
%Histogram Equalization
equalized_image = zeros(M, N);
for i = 1: M %traverse
    for j = 1: N
        intensity = ori_img_grain(i, j);
        equalized_image(i, j) = round(255* Cdf((intensity + 1))); %Substitude
    end
end
%plot new image
subplot(1, 2, 1);
imshow(uint8(equalized_image));
title("Histogram Equalized Image");

%New Histogram
new_counts = zeros(1, 256);
for i = 1: M %traverse
    for j = 1: N
        intensity = equalized_image(i, j);
        new_counts(intensity + 1) = 1 + new_counts(intensity + 1); %count
    end
end
%plot histogram of new image
subplot(1, 2, 2);
bar(0:255, new_counts);
xlabel("Intensity value");
ylabel("Number of pixels");
title("Histogram of Equalized Image");
