function [ gray_centiles ] = gray_level_centiles( mat,centiles )
%GRAY_LEVEL_CENTILES Summary of this function goes here
%   Detailed explanation goes here
if(size(mat,3)>1)
   mat=rgb2gray(mat);
end
col = sortIntoVector(mat(:,:));

gray_centiles=prctile(col,centiles)';

end
