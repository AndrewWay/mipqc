function [ verdict ] = point_is_in_box( x,y,p1,p2,p3,p4 )
%POINT_IS_IN_BOX Summary of this function goes here
%   Detailed explanation goes here
xv=[p1(1,1),p2(1,1),p3(1,1),p4(1,1)];
yv=[p1(2,1),p2(2,1),p3(2,1),p4(2,1)];

verdict=inpolygon(x,y,xv,yv);

end

