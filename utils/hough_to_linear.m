function [ func ] = hough_to_linear( theta,rho )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if(mod(theta,pi)==0)
    func=@(x) x;
else
    func = @(x) (rho - x*cos(theta))/sin(theta);
end

end

