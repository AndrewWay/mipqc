function [ surface_area ] = calc_surface_area( xints,yints )
%CALC_SURFACE_AREA Summary of this function goes here
%   Detailed explanation goes here


x=[xints(1,1),xints(1,2),xints(2,2),xints(2,1),xints(1,1)];
y=[yints(1,1),yints(1,2),yints(2,2),yints(2,1),yints(1,1)];
surface_area=polyarea(x,y);

end

