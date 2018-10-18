function [ rcentiles,gcentiles,bcentiles ] = createCentileVec( rgbMat,centiles )
%Given a matrix of RGB vectors, it returns a single feature vector

rcol = sortIntoVector(rgbMat(:,:,1));
gcol = sortIntoVector(rgbMat(:,:,2));
bcol = sortIntoVector(rgbMat(:,:,3));

rcentiles = prctile(rcol,centiles)';
gcentiles = prctile(gcol,centiles)';
bcentiles = prctile(bcol,centiles)';

end