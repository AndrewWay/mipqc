%Rescale the image if necessary. High resolution is not necessary and 
%increases computation time. 
clear all
close all


I0 = imread('../test_image2.jpg');

if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end