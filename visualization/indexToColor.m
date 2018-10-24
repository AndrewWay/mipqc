function [ rgb_vector ] = indexToColor( index,dim1,dim2 )
%INDEXTOCOLOR Summary of this function goes here
%   Detailed explanation goes here
index_row=floor(index/dim1);
index_col=mod(index,dim2);

if(index_col==0)
    index_col=dim2;
else
    index_row=index_row+1;
end


theta=(pi/2)*index_col/dim2;
rho=(pi/2)*index_row/dim1;

v1=[1,0,0];
v2=[0,1,0];
v3=[0,0,1];
v4=[1,1,0];

% r=sin(theta)*cos(rho);
% g=sin(theta)*sin(rho);
% b=(cos(theta)+index_row/dim1)/2;
% 
% rgb_vector=[r,g,b];

rgb_vector=(index_row-1)*v1+(dim1-index_row)*v2+...
    (index_col-1)*v3+(dim2-index_col)*v4/3;
rgb_vector=rgb_vector/norm(rgb_vector,2);
end

