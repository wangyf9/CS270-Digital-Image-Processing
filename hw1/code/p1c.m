%pwd
ori_img_tire = imread('..\image\tire.tif');

[M, N] = size(ori_img_tire)
patch_size = 41;
step = 1;
half_patch = (patch_size - 1) / 2;
clip_threshold = 0.02;
padded_img = padarray(ori_img_tire, [half_patch, half_patch], 'replicate');
[new_M, new_N] = size(padded_img);
imshow(padded_img)
new = padded_img(21:new_M-20,21:new_N-20);
figure;
clahe_img = zeros(new_M, new_N);
%clahe_img = zeros(M, N);
%traverse
for i = (1 + half_patch): step: (new_M - half_patch)
    for j = (1 + half_patch): step: (new_N - half_patch)
        %get patch
        patch = padded_img((i - half_patch): (i + half_patch), (j - half_patch): (j + half_patch));
        %get batch histogram
        patch_counts = zeros(1, 256);
        for z = 1: patch_size
            for k = 1: patch_size
                intensity = patch(z, k);
                patch_counts(intensity + 1) = patch_counts(intensity + 1) + 1;
            end
        end
        %Normalize
        Normalized_patch = patch_counts/(patch_size * patch_size);
        %clip > 0.02
        total_part = sum(max(0, Normalized_patch - clip_threshold));
        Normalized_patch = Normalized_patch - max(0, Normalized_patch - clip_threshold);
        Normalized_patch = Normalized_patch + total_part / 256;
        %cdf
        cdf = cumsum(Normalized_patch);
        %Equalized
        Equalized_patch = zeros(patch_size, patch_size);
        for z = 1: patch_size %traverse
            for k = 1: patch_size
                intensity = patch(z, k);
                Equalized_patch(z, k) = round(255* cdf((intensity + 1))); %Substitude
            end
        end
        clahe_img((i - half_patch):(i - half_patch + 2),(j - half_patch):(j - half_patch + 2)) = Equalized_patch((1 + half_patch - 1):(1 ...
            + half_patch + 1),(1 + half_patch - 1):(1 + half_patch + 1));
    end
end

final = clahe_img(1+1:M+1, 1+1:N+1);
size(final)
%plot new image
subplot(1, 2, 1);
imshow(uint8(final));
title('CLAHE Processed Image');
%New Histogram
new_counts = zeros(1, 256);
for i = 1: M %traverse
    for j = 1: N -2
        intensity = final(i, j);
        new_counts(intensity + 1) = 1 + new_counts(intensity + 1); %count
    end
end
%plot histogram of new image
subplot(1, 2, 2);
bar(0:255, new_counts);
xlabel("Intensity value");
ylabel("Number of pixels");
title("Histogram of Equalized Image");





