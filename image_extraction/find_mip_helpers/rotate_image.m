function [I] = rotate_image(I,angle)
%ROTATE_IMAGE Summary of this function goes here
%   Detailed explanation goes here
    I=rotate_around(I,0,0,angle,'bilinear');
end

