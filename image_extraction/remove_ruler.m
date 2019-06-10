function [I] = remove_ruler(I)
%REMOVE_RULER Removes part of image containing ruler
rotation_angle=0.7030;
chop_height=2523;
%Rotate image
I=rotate_image(I,rotation_angle);
I=I(1:chop_height,:,:);
end

