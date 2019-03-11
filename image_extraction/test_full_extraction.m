clear all
close all


%I = imread('data/C/C10t.jpg');
%I=I(:,981:3579,:);

I=imread('data/B/MIP9_original.jpg');
%I=imread('test_image.jpg');
% Find the checkerboard. Return the four outer corners as a 4x2 array,
% in the form [ [x1,y1]; [x2,y2]; ... ].
MIP=extract_mip(I);

figure(1), imshow(I), title('Original Picture');
figure(2), imshow(MIP), title('Extracted MIP');