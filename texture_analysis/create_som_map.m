close all;

nObs=size(W,1);

mapIndices = zeros(nObs,2);
index=1;

for i=1:nObs
    feature_vector=W(i,:)';
    neuronIndex=vec2ind(net(feature_vector));
    
    [I,J]=ind2sub([som_dim1,som_dim2],neuronIndex);
    
    mapIndices(i,1)=I;
    mapIndices(i,2)=J;
end
if(exist('classifier','var'))
    createMapImage(image_cells,mapIndices,classifier);
else
    createMapImage(image_cells,mapIndices); 
end