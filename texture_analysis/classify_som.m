function [ classified ] = classify_som( cells,net,classifier,zmu,zsigma,som_dim1,som_dim2)
%CLASSIFY Classifies a image cell using a SOM
nObservations=size(cells,1);
classified=zeros(nObservations,1);

for i=1:nObservations
    img=cell2mat(cells(i,1));
    featVec = create_feature_vector(img,nFeatures);
    featVec=(featVec-zmu)./zsigma;
    featVec = featVec*tCoeff;
    clusterIndex=vec2ind(net(featVec'));
    
    [in,jn]=ind2sub([som_dim1,som_dim2],clusterIndex);
    
    classified(i,1)=classifier(in,jn);
end

end

