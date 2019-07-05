
close all;
number_of_pcs=4;
nFeatures=20;
%close(figure(1));
%Use the following line if you don't want tom  extract
%MIP=I;
data=zeros(nObservations,nFeatures);
for i=1:nObservations
    mat=cell2mat(image_cells(i));
    feature_vector=create_feature_vector(mat,nFeatures);
    data(i,:)=feature_vector;
end

[zdata,zmu,zsigma]=zscore(data);%Use this data to use correlation matrix in PCA

[coeff,score,latent,~,explained] = pca(zdata);
tCoeff=coeff(:,1:number_of_pcs);

tData = zdata*tCoeff;
W=tData;