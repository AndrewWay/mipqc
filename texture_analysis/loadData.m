%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

close all;
clear all;

%PARAMETERS
startIndex=6858;
stopIndex=6860;%7008;
nImages = stopIndex-startIndex;

img_dim1Divisions=40;
img_dim2Divisions=40;

nFeatures=20;

%each row in data corresponds to the same row in imageCells. 
nObservations=nImages*img_dim1Divisions*img_dim2Divisions;
data = zeros(nObservations,nFeatures);%matrix with each row being an observation.
image_cells = [];%column vector containing cells of images

%Load images into memory
cellIndex=1;

for k=startIndex:stopIndex
    pngFileName=strcat('data/D/D', num2str(k), '.png');
    if exist(pngFileName, 'file')
        fprintf("Processing MIP D%d\n",k);
        %Read MIP image to matrix
        MIP = imread(pngFileName);
    
        regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
        regionCells_dim1=size(regionCells,1);
        regionCells_dim2=size(regionCells,1);

        %close(figure(1));
        %Use the following line if you don't want tom  extract
        %MIP=I;
        
        for ii=1:regionCells_dim1
            for jj=1:regionCells_dim2
                cell=regionCells(ii,jj);
                mat=cell2mat(cell);
                feature_vector=create_feature_vector(mat,nFeatures);
                data(cellIndex,:)=feature_vector;
                image_cells=[image_cells;cell];
                cellIndex=cellIndex+1;
            end
        end
    else
        fprintf('File %s does not exist.\n', pngFileName);
    end
end

[zdata,zmu,zsigma]=zscore(data);%Use this data to use correlation matrix in PCA

[coeff,score,latent,~,explained] = pca(zdata);
tCoeff=coeff(:,1:4);

tData = zdata*tCoeff;
W=tData;