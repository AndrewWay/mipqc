function [ mgl ] = median_gray_level( I )
%MEDIAN_GRAY_LEVEL Summary of this function goes here
%   Detailed explanation goes here

size1=size(I,1);
size2=size(I,2);
size3=size(I,3);

if(size3>1)
    I=rgb2gray(I);    
end

I=sortIntoVector(I);

mgl=median(I);

end

