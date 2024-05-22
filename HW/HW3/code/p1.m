clf,clear;
load('../sinogram.mat');
[n_projections,n_angles] = size(sinogram);
M = n_projections;
%FFT
fft_sinogram = fftshift(fft(sinogram, [], 1), 1);

%Ramp filter
filter = my_ramp_filter(M,n_angles);
%conv
filtered_fft_sinogram = fft_sinogram .* filter';

%ifft

filtered_sinogram = real(ifft(ifftshift(filtered_fft_sinogram, 1), [], 1));
%FBP
reconstructed = zeros(M, M);
for i = 1:n_angles
    single_projection = filtered_sinogram(:, i);
    single_projection = repmat(single_projection, [1, M]);
    rotated = imrotate(single_projection, -i, 'crop', 'bilinear');
    reconstructed = reconstructed + rotated;
end
reconstructed = reconstructed';
imshow(reconstructed, []);
title("FBP Reconstructed Image");

%Hamming window
function w = my_hamming(M)
    n = 0:M-1;
    w = 0.54 - 0.46 * cos(2 * pi * n / (M - 1));
    size(w)
end

%ramp filter(abs) with hamming window
function filter = my_ramp_filter(n_projections,n_angles)
    Hamming_window = my_hamming(n_projections);
    Hamming_ramp = abs(ceil(n_projections / 2) - (1:n_projections)) / n_projections;
    filter = Hamming_window .* Hamming_ramp;
    filter = repmat(filter, n_angles, 1);
end


