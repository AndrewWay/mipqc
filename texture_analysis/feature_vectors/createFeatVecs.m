function [ data ] = createFeatVecs( rgbMat,nFeats,img_dim1Divisions,img_dim2Divisions)
%CREATEFEATVECS Summary of this function goes here
%   Detailed explanation goes here


regionCells = dice(rgbMat,img_dim1Divisions,img_dim2Divisions);

%connectiveness feature vector component
%f_dif=connectiveness(f_blob,f_truth);
data=zeros(img_dim1Divisions*img_dim2Divisions,nFeats);
data_index=1;

for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        
        rgbmat=cell2mat(regionCells(i,j));
        
        data(data_index,:)=create_feature_vector(rgbmat,nFeats);
        
        data_index=data_index+1;
        
    end
end

end

