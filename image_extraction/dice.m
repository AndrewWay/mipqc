function [ regions ] = dice( matrix,dim1Divs,dim2Divs )
%Dices a matrix into regions
%ARGUMENTS
%dim1Divs - number of divisions along dimension 1
%dim2Divs - number of divisions along dimension2 
%The 3D matrix, with 3rd dimension having 3 components, to be divided
%OUTPUT
%Cell containing regions of matrix
matDim1 = size(matrix,1);
matDim2 = size(matrix,2);

dim1RegionSizes = dice_helper(matDim1,dim1Divs);
dim2RegionSizes = dice_helper(matDim2,dim2Divs);

regions = mat2cell(matrix,dim1RegionSizes,dim2RegionSizes,[3]);


end