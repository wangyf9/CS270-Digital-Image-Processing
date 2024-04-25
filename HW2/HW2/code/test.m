clc;
clear;
Img=imread('..\figure\blurred.tif');
Idouble=im2double(Img);
PSF=fspecial('motion',20,30);
PSF1=fspecial('motion',19,120);
blurred=imfilter(Idouble,PSF,'circular');
%weiner= deconvwnr(Idouble,PSF1); %weiner restortion
%weiner= deconvwnr(Img,PSF1); %weiner restortion
%imshow(weiner,[]);title('Weiner Restortion');
figure('name','Image Restortion using Weiner');
for j = 101:150
        subplot(5,10,(j-100));
        PSF1=fspecial('motion',0.1,j);
        weiner= deconvwnr(Img,PSF1); %weiner restortion
        imshow(weiner,[]);title('Weiner Restortion');
end