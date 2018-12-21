%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

close all;
clear all;

%PARAMETERS
numOfImages=5;
img_dim1Divisions=40;
img_dim2Divisions=40;


nFeatures=19;


%each row in data corresponds to the same row in imageCells. 
data = [];%matrix with each row being an observation.
image_cells = [];%column vector containing cells of images

%Load images into memory
for k=1:numOfImages
    pngFileName = strcat('data/B/MIP', num2str(k), '.jpg');
    if exist(pngFileName, 'file')
        disp(pngFileName);
        %Read MIP image to matrix
        I = imread(pngFileName);
        
% 
%         figure(1), imshow(I);
%         pause;
%         close(figure(1));
%         
        
        % Find and return the MIP.
        [MIP]=extract_mip(I);
        regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
        regionCells_dim1=size(regionCells,1);
        regionCells_dim2=size(regionCells,1);
        %MIP=I;
%         figure(1),imshow(MIP);
%         pause;
%         close(figure(1));
        %Use the following line if you don't want tom  extract
        %MIP=I;
        
        for ii=1:regionCells_dim1
            for jj=1:regionCells_dim2
                cell=regionCells(ii,jj);
                mat=cell2mat(cell);
                feature_vector=create_feature_vector(mat,nFeatures);
                data=[data;(feature_vector)];
                image_cells=[image_cells;cell];
            end
        end
    else
        fprintf('File %s does not exist.\n', pngFileName);
    end
end

%data=zscore(data);%Uncomment this line to use correlation matrix in PCA

[coeff,score,latent,~,explained] = pca(data);
tCoeff=coeff(:,1:2);

tData = data*tCoeff;
W=tData;