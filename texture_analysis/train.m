%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

close all;
clear all;

%PARAMETERS
numOfImages=32;
img_dim1Divisions=40;
img_dim2Divisions=40;
som_dim2 = 20;
som_dim3 = 20;


nFeats=6;

featVecs = zeros(nFeats,img_dim1Divisions,img_dim2Divisions,numOfImages);

%Load images into memory
for k=9:numOfImages
    pngFileName = strcat('../Surface Defect Detection/defectdetect/MIPs/C/C'...
        , num2str(k), 't.jpg');
    if exist(pngFileName, 'file')
        disp(pngFileName);
        %Read MIP image to matrix
        I = imread(pngFileName);
        
        %!!!!DELETE
        if(k<=10)
            I=I(:,900:3480,:);% DELETE THIS!!
        else
            I=I(:,1485:4090,:);% DELETE THIS!!
        end
        %!!!!
        
        % Find and return the MIP.
        [MIP]=extract_mip(I);
        
        imshow(MIP);
        pause;
        %Use the following line if you don't want tom  extract
        %MIP=I;
        imageDim1 = size(MIP,1);
        imageDim2 = size(MIP,2);
        
        featVecs(:,:,:,k)=createFeatVecs(MIP,nFeats,img_dim1Divisions,img_dim2Divisions);
    else
        fprintf('File %s does not exist.\n', pngFileName);
    end
end

%Initialize SOM
%Set each vector in the SOM to a vector of random weights

net = selforgmap([som_dim2 som_dim3]);


numOfFeatVecs = numOfImages*img_dim1Divisions*img_dim2Divisions;

featVecIndex=zeros(3,numOfFeatVecs);
inputs=zeros(nFeats,numOfFeatVecs);

featVecCounter=1;

for k=1:numOfImages
    for i=1:img_dim1Divisions
        for j=1:img_dim2Divisions
            for l=1:nFeats
                inputs(l,featVecCounter)=featVecs(l,i,j,k);
            end
            featVecCounter=featVecCounter+1;
        end
    end
end
[net, tr] =train(net,inputs);

%som = SOM(nFeats,som_dim2,som_dim3);

%TRAINING
%[som,trainingErrorTimeSeries] = som.Train(featVecs,nIterations);

%plot(trainingErrorTimeSeries);