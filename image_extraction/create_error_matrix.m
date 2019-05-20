function [error_matrix] = create_error_matrix(cells,SOM,nFeatures,zmu,zsigma,tCoeff)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dim1=size(cells,1);
dim2=size(cells,2);
error_matrix=zeros(dim1,dim2);
for i=1:dim1
    for j=1:dim2
        img_ij = cell2mat(cells(i,j));
        featVec = create_feature_vector(img_ij,nFeatures);
        %MUST ZSCORE THIS DATA TO MATCH ZDATA (refer to loadData.m)
        featVec=(featVec-zmu)./zsigma;
        featVec = featVec*tCoeff;
        
        error_matrix(i,j)=BMU_error(SOM,featVec);
        
    end
end

end

