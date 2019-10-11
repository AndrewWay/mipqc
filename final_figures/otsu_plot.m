clear all;
close all;

I = imread('gradient_mip.jpg');
G=rgb2gray(I);
imshow(I);

%hist(I(:))