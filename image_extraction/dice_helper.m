function [ regionSizes ] = dice_helper( dim,divs )
%Calculates number of pixels along one dimension of an image region
%ARGUMENTS
%dim - number of elements along the dimension
%divs - number of divisions 

dimInc = floor(dim / divs);
dimRem = mod(dim,divs);
regionSizes = zeros(1,divs);
regionSizes(1,1:divs-1)=dimInc;
regionSizes(1,divs)=dimInc+dimRem;

end