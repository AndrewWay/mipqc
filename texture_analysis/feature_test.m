
% if exist('mip','var')==0
%     I=imread('B5.jpg');
%     mip=extract_mip(I);
%     imshow(mip);
% end
clear all;
close all;

nFeats=15;

img_dim1Divisions=20;
img_dim2Divisions=40;

means=zeros(img_dim1Divisions,img_dim2Divisions);
medians=zeros(img_dim1Divisions,img_dim2Divisions);
stds=zeros(img_dim1Divisions,img_dim2Divisions);
skewnesses=zeros(img_dim1Divisions,img_dim2Divisions);
kurtoses=zeros(img_dim1Divisions,img_dim2Divisions);

%Calculate GLCM for Haralick features
asms=zeros(img_dim1Divisions,img_dim2Divisions);
contrasts=zeros(img_dim1Divisions,img_dim2Divisions);
correlations=zeros(img_dim1Divisions,img_dim2Divisions);
vars=zeros(img_dim1Divisions,img_dim2Divisions);%sum of squares
ivds=zeros(img_dim1Divisions,img_dim2Divisions);
sumavgs=zeros(img_dim1Divisions,img_dim2Divisions);
sumvars=zeros(img_dim1Divisions,img_dim2Divisions);
suments=zeros(img_dim1Divisions,img_dim2Divisions);
ents=zeros(img_dim1Divisions,img_dim2Divisions);
diffvars=zeros(img_dim1Divisions,img_dim2Divisions);
diffents=zeros(img_dim1Divisions,img_dim2Divisions);
imc1s=zeros(img_dim1Divisions,img_dim2Divisions);
imc2s=zeros(img_dim1Divisions,img_dim2Divisions);
mccs=zeros(img_dim1Divisions,img_dim2Divisions); %max correlation coeff.

numOfImages=1;
data=zeros(numOfImages*img_dim1Divisions*img_dim2Divisions,nFeats);
data_index=1;


for k=3:3
    pngFileName = strcat('data/B/MIP', num2str(k), '.jpg');
    I = imread(pngFileName);
    mip=extract_mip(I);
    regionCells = dice(mip,img_dim1Divisions,img_dim2Divisions);
    for i=1:img_dim1Divisions
        for j=1:img_dim2Divisions
            %
            rgbmat=cell2mat(regionCells(i,j));
            gmat=rgb2gray(rgbmat);
            glcm = graycomatrix(gmat, 'offset', [0 1], 'Symmetric', true);
            %             means(i,j)=mean_gray_level(rgbmat);
            %             medians(i,j)=median_gray_level(rgbmat);
            x=haralick_features(glcm);
            %             asms(i,j)=x(1);
            %             contrasts(i,j)=x(2);
            %             correlations(i,j)=x(3);
            %             vars(i,j)=x(4);
            %             ivds(i,j)=x(5);
            %             sumavgs(i,j)=x(6);
            %             sumvars(i,j)=x(7);
            %             suments(i,j)=x(8);
            %             ents(i,j)=x(9);
            %             diffvars(i,j)=x(10);
            %             diffents(i,j)=x(11);
            %             imc1s(i,j)=x(12);
            %             imc2s(i,j)=x(13);
            %             mccs(i,j)=x(14);
            
            data(data_index,1)=mean_gray_level(rgbmat);
            data(data_index,2)=median_gray_level(rgbmat);
            data(data_index,3)=x(1);
            data(data_index,4)=x(2);
            data(data_index,5)=x(3);
            data(data_index,6)=x(4);
            data(data_index,7)=x(5);
            data(data_index,8)=x(6);
            data(data_index,9)=x(7);
            data(data_index,10)=x(8);
            data(data_index,11)=x(9);
            data(data_index,12)=x(10);
            data(data_index,13)=x(11);
            %data(data_index,14)=x(12);
            data(data_index,14)=x(13);
            data(data_index,15)=x(14);
            
            data_index=data_index+1;
        end
    end
end

[coeff,score,latent,~,explained] = pca(data);
% Calculate eigenvalues and eigenvectors of the covariance matrix
covarianceMatrix = cov(data);
[V,D] = eig(covarianceMatrix);
% "coeff" are the principal component vectors. These are the eigenvectors of the covariance matrix. Compare ...
%coeff
V
% Multiply the original data by the principal component vectors to get the projections of the original data on the
% principal component vector space. This is also the output "score". Compare ...
dataInPrincipalComponentSpace = data*coeff
score
% The columns of X*coeff are orthogonal to each other. This is shown with ...
corrcoef(dataInPrincipalComponentSpace)
% The variances of these vectors are the eigenvalues of the covariance matrix, and are also the output "latent". Compare
% these three outputs
var(dataInPrincipalComponentSpace)'
latent
sort(diag(D),'descend')

fileID = fopen('pca.txt','w');
for i=1:nFeats
    for j=1:nFeats
        fprintf(fileID,'%6.2f',coeff(i,j));
    end
    fprintf(fileID,'\n');
end
fclose(fileID);
