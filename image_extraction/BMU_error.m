function [err] = BMU_error(SOM,featVec)
%UNTITLED Calculates distance from feature vector and BMU in SOM
neuron_matrix = cell2mat(SOM.IW);
clusterIndex=vec2ind(SOM(featVec'));

err = norm(neuron_matrix(clusterIndex)-featVec,2);

end

