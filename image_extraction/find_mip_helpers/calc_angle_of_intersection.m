function [ th ] = calc_angle_of_intersection( line1, line2,other_line1,other_line2 )
%CALC_ANGLE_OF_INTERSECTION Summary of this function goes here
%   Detailed explanation goes here
% linex is of the form [theta;rho]
shift=0;
if(abs(other_line1(2,1))>abs(line1(2,1)))
    th=abs(abs(line1(1,1))-abs(line2(1,1)));
else
    th=180-abs(abs(line1(1,1))-abs(line2(1,1)));    
end




end

