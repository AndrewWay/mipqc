function [t] = calc_angle_of_intersection(origin,u,v)
%CALC_ANGLE_OF_INTERSECTION Summary of this function goes here
%   Detailed explanation goes here
% linex is of the form [theta;rho]


u=u-origin;
v=v-origin;
CosTheta = dot(u,v)/(norm(u)*norm(v));
t = acosd(CosTheta);

end

