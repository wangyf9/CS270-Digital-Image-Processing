%pwd
ori_img = imread('..\figure\PeppersRGB.jpg');
%normalize input
stand_ori_img = im2double(ori_img);
[M, N, d] = size(stand_ori_img);
R = stand_ori_img(:,:,1);
G = stand_ori_img(:,:,2);
B = stand_ori_img(:,:,3);
H = zeros(M, N);
S = zeros(M, N);
I = zeros(M, N);
% RGB to HSI
for i = 1: M
    for j = 1: N
        r = R(i,j);
        g = G(i,j);
        b = B(i,j);
        theta = acos((0.5*((r - g) + (r - b))) / sqrt(((r - g)^2) + ((r - b) * (g - b))) + eps);
        if (g < b)
            H(i,j) = 2*pi - theta;
        else
            H(i,j) = theta;
        end
        %normalize H (Angle of rotation in radian)
        H(i,j) = H(i,j) / (2*pi);
        S(i,j) = 1 - (3 / ((r + g + b)+eps)) * (min(r, min(g, b)));
        I(i,j) = (r + g + b) / 3;
    end
end
hsi_image = (cat(3, (H), (S), (I)));
%normalize input
stand_hsi = im2double(hsi_image);
figure;
subplot(1,3,1);
imshow(ori_img);
title("Original RGB Image");
subplot(1,3,2);
imshow(stand_hsi);
title("HSI Image");
new_R = zeros(M, N);
new_G = zeros(M, N);
new_B = zeros(M, N);
new_H = stand_hsi(:,:,1);
new_S = stand_hsi(:,:,2);
new_I = stand_hsi(:,:,3);
%  HSI to RGB
for i = 1: M
    for j = 1: N
        h = new_H(i,j) * 2* pi;
        s = new_S(i,j);
        i_c = new_I(i,j);
        if 0 <= h && h < ((2 * pi)/3)
            new_B(i,j) = i_c * (1 - s);
            new_R(i,j) = i_c * (1 + (s * cos(h))/ (cos((pi / 3) - h)) + eps);
            new_G(i,j) = 3 * i_c - (new_R(i,j) + new_B(i,j));
        elseif ((2 * pi)/3) <= h && h < ((4 * pi)/3)
            new_R(i,j) = i_c * (1 - s);
            new_G(i,j) = i_c * (1 + (s * cos(h - ((2 * pi)/3)))/ (cos(pi - h)) + eps);
            new_B(i,j) = 3 * i_c - (new_R(i,j) + new_G(i,j)); 
        elseif ((4 * pi)/3) <= h && h < 2*pi
            new_G(i,j) = i_c * (1 - s);
            new_B(i,j) = i_c * (1 + (s * cos(h - ((4 * pi)/3)))/ (cos(((5 * pi) / 3) - h)) + eps);
            new_R(i,j) = 3 * i_c - (new_B(i,j) + new_G(i,j)); 
        end
    end
end
new_R;
new_image = 255 * cat(3, (new_R), (new_G), (new_B));
subplot(1,3,3);
imshow(uint8(new_image));
title("Transform RGB Image");