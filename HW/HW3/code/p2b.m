image = imread('../figure/nebula.jpg');
gray_image = rgb2gray(image);
[M, N] = size(gray_image);
%padding to square
max_dim = 2^nextpow2(max(size(gray_image)));
gray_image = padarray(gray_image, [max_dim-M, max_dim-N], 'post');

%set parameters
min_dim_1 = 8;
min_dim_2 = 4;

region_split_merge(image,gray_image,min_dim_1);
region_split_merge(image,gray_image,min_dim_2);

function region_split_merge(image,gray_image,min_dim)
    [m, n] = size(rgb2gray(image));
    [new_M,new_N] = size(gray_image);
    %split squarter
    s = qtdecomp(gray_image, @split, min_dim, @predicate);
    lmax = full(max(s(:)));
    
    %init
    g = zeros(new_M,new_N);
    %travel merge
    for k = 1:lmax
        [vals, R, C] = qtgetblk(gray_image, s, k);
        if ~isempty(vals)
            for i = 1:length(R)
                x_low = R(i);
                y_low = C(i);
                x_high = x_low + k - 1;
                y_high = y_low + k - 1;
                sub_region = gray_image(x_low:x_high, y_low:y_high);
                bool = predicate(sub_region);
                if bool
                    g(x_low:x_high, y_low:y_high) = 1;
                end
            end
        end
    end
    g = g(1:m, 1:n);
    figure;
    subplot(1,3,1);
    imshow(image);
    title("Original Image");
    subplot(1,3,2);
    imshow(g)
    title(['Split And Merge Result when Min Dim = ', num2str(min_dim)]);
    gray_image = gray_image(1:m, 1:n);
    BWoutline = bwperim(g);
    Segout = gray_image;
    Segout(BWoutline) = 255;
    subplot(1,3,3);
    imshow(Segout); 
    
    title(['Split And Merge Result Represents in Original Gray Imagewhen Min Dim = ', num2str(min_dim)]);
end

% Q(R_i)
function bool = predicate(region)
    sigma = std2(region);  
    mu = mean2(region);  
    bool = (sigma > 0.7) & (mu > 0) & (mu < 170);
end

% split
function R = split(b, min_dim, fun)
    k = size(b, 3);
    R(1: k) = false;
    for i = 1: k
        quadrgn = b(:, :, i);
        if size(quadrgn, 1) <= min_dim
            R(i) = false;
            continue;
        end
        bool = feval(fun, quadrgn);
        if bool
            R(i) = true;
        end
    end
end
