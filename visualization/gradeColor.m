function [ rgb_vector ] = gradeColor( grade )
%GRADECOLOR Summary of this function goes here
%   Detailed explanation goes here
v1=[1,0,0];
v2=[0,1,0];
v3=[0,0,1];
v4=[1,1,0];

rgb_vector=grade*v2+(1-grade)*v1;
rgb_vector=rgb_vector/norm(rgb_vector,2);

end

