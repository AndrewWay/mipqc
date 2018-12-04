%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

close all;
clear all;

%PARAMETERS
numOfImages=9;
img_dim1Divisions=40;
img_dim2Divisions=40;
som_dim2 = 20;
som_dim3 = 20;


nFeats=14;


data = [];
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
%         figure(1),imshow(MIP);
%         pause;
%         close(figure(1));
        %Use the following line if you don't want tom  extract
        %MIP=I;
        imageDim1 = size(MIP,1);
        imageDim2 = size(MIP,2);
        
        data=[data;createFeatVecs(MIP,nFeats,img_dim1Divisions,img_dim2Divisions)];
    else
        fprintf('File %s does not exist.\n', pngFileName);
    end
end

%Initialize SOM
%Set each vector in the SOM to a vector of random weights
net = selforgmap([som_dim2 som_dim3]);
[coeff,score,latent,~,explained] = pca(data);
tCoeff=coeff(:,1:2);
tData = data*tCoeff;
X=tData;
%inputs=data';

%[net, tr] =train(net,inputs);

%som = SOM(nFeats,som_dim2,som_dim3);

%TRAINING
%[som,trainingErrorTimeSeries] = som.Train(featVecs,nIterations);

%plot(trainingErrorTimeSeries);