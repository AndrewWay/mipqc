function [ mgl ] = median_gray_level( I )
%MEDIAN_GRAY_LEVEL Summary of this function goes here
%   Detailed explanation goes here

size1=size(I,1);
size2=size(I,2);
size3=size(I,3);

if(size3>1)
    I=rgb2gray(I);    
end

mgl=0;
for i=1:size1
    for j=1:size2
        px_gl=double(I(i,j));
       mgl=double(mgl+px_gl);
    end    
end
mgl=double(mgl/(size1*size2));

end

