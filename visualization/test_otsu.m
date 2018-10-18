close all;
clear all;

I=imread('mip_transmitted.jpg');
I=I(:,1418:4166,:);
imshow(I);

pause;

if size(I,3)>1
    I = rgb2gray(I);
end

E = edge(I,'canny',0.54);

otsu_thres=graythresh(I);
disp(otsu_thres);
E_otsu=edge(I,'canny',otsu_thres);



figure(1), imshow(E);
figure(2), imshow(E_otsu);
figure(3), histogram(I);