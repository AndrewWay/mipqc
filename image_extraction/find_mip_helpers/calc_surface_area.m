function [ surface_area ] = calc_surface_area( xints,yints )
%CALC_SURFACE_AREA Summary of this function goes here
%   Detailed explanation goes here


x=[xints(1,1),xints(1,2),xints(2,2),xints(2,1),xints(1,1)];
y=[yints(1,1),yints(1,2),yints(2,2),yints(2,1),yints(1,1)];
surface_area=polyarea(x,y);

calibration_factor=1/pixel_to_mm(1);%number of pixels per mm

surface_area=surface_area/(calibration_factor^2);

end

