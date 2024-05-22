image = im2double(imread('../figure/seahouse.jpg'));
I_lab = rgb2lab(image);
%set paras
M = 40;
threshold = 0.01;
res1 = superpixel(100,I_lab,M,threshold);
res2 = superpixel(500,I_lab,M,threshold);
res3 = superpixel(1000,I_lab,M,threshold);
figure;
subplot(2,2,1);
imshow(image);
title("Original image");
subplot(2,2,2);
imshow(res1);
title("When k = 100, m = 40, threshold = 0.01, superpixeled image");
subplot(2,2,3);
imshow(res2);
title("When k = 500, m = 40, threshold = 0.01, superpixeled image");
subplot(2,2,4);
imshow(res3);
title("When k = 1000, m = 40, threshold = 0.01, superpixeled image");

function res = superpixel(K,I_lab,M,threshold)
    [R,C,~] = size(I_lab);
    %calculate paras
    total_Num = R*C;
    S = floor(sqrt(total_Num/K));
    %init
    cluster_centers = zeros(K,2);
    label = zeros(R,C);
    dis = inf(R,C);
    %init cluster centers by sampling
    cluster_index = 1;
    h = floor(S/2);
    w = floor(S/2);
    while h < R
        while w < C
            cluster_centers(cluster_index,:) = [h,w];
            cluster_index = cluster_index + 1;
            w = w + S;
        end
        w = floor(S/2);
        h = h + S;
    end
    K = cluster_index - 1;
    cluster_centers = cluster_centers(1:K,:);
    %move cluster centers to local gradient minimum 3*3
    for cluster_index = 1:K
        cluster_h = cluster_centers(cluster_index,1);
        cluster_w = cluster_centers(cluster_index,2);

        min_gradient = Inf;
        min_h = cluster_h;
        min_w = cluster_w;
        for dh = -1:1
            for dw = -1:1
                nh = cluster_h + dh;
                nw = cluster_w + dw;
                if nh < 1 || nh > R || nw < 1 || nw > C
                    continue;
                end
                grad_l = I_lab(nh,nw,1) - I_lab(cluster_h,cluster_w,1);
                grad_a = I_lab(nh,nw,2) - I_lab(cluster_h,cluster_w,2);
                grad_b = I_lab(nh,nw,3) - I_lab(cluster_h,cluster_w,3);
                gradient = sqrt(grad_l^2 + grad_a^2 + grad_b^2);
    
                if gradient < min_gradient
                    min_gradient = gradient;
                    min_h = nh;
                    min_w = nw;
                end
            end
        end
    
        %update
        cluster_centers(cluster_index,:) = [min_h,min_w];
    end
    %iterate
    E = Inf;
    while E > threshold
        for cluster_index = 1:K
            cluster_h = cluster_centers(cluster_index,1);
            cluster_w = cluster_centers(cluster_index,2);
            %2S * 2S region
            for h = cluster_h-S:cluster_h+S
                if h < 1 || h > R
                    continue;
                end
                for w = cluster_w-S:cluster_w+S
                    if w < 1 || w > C
                        continue;
                    end
                    % pos + color
                    cluster_l = I_lab(cluster_h,cluster_w,1);
                    cluster_a = I_lab(cluster_h,cluster_w,2);
                    cluster_b = I_lab(cluster_h,cluster_w,3);
                    cur_l = I_lab(h,w,1);
                    cur_a = I_lab(h,w,2);
                    cur_b = I_lab(h,w,3);
                    d_c = sqrt((cluster_l-cur_l)^2 + (cluster_a-cur_a)^2 + (cluster_b-cur_b)^2);
                    d_s = sqrt((cluster_h-h)^2 + (cluster_w-w)^2);
                    d = sqrt((d_c/M)^2 + (d_s/S)^2);
                    if d < dis(h,w)
                        label(h,w) = cluster_index;
                        dis(h,w) = d;
                    end
                end
            end
        end
        %calculate error
        cluster_centers_pre = cluster_centers;
        for cluster_index = 1:K
            sum_h = 0;
            sum_w = 0;
            indexs = find(label == cluster_index);
            for idx = 1:length(indexs)
                sum_w = sum_w + floor(indexs(idx)/R) + 1;
                sum_h = sum_h + indexs(idx) - floor(indexs(idx)/R)*R;
            end
            new_h = floor(sum_h / length(indexs));
            new_w = floor(sum_w / length(indexs));
            cluster_centers(cluster_index,:) = [new_h,new_w];
        end
        dif = cluster_centers - cluster_centers_pre;
        E = sum(sum(dif .^ 2));
    
    end
    %get
    res_lab = I_lab;
    for h = 1:R
        for w = 1:C
            cluster_index = label(h,w);
            cluster_h = cluster_centers(cluster_index,1);
            cluster_w = cluster_centers(cluster_index,2);
            res_lab(h,w,:) = I_lab(cluster_h,cluster_w,:);
        end
    end
    %revert
    res = lab2rgb(res_lab);
end


