%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs

%Initialize SOM
%Set each vector in the SOM to a vector of random weights
som_dim2 = 20;
som_dim3 = 20;

net = selforgmap([som_dim2 som_dim3]);

inputs=X';

[net, tr] =train(net,inputs);

pngFileName = strcat('data/B/MIP5.jpg');
if exist(pngFileName, 'file')
    
    %Read into MIP image to matrices
    I = imread(pngFileName);

    % Find and return the MIP.
    [MIP]=extract_mip(I);
        
    %Use the following line if you don't want to extract
    % MIP=I;
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    %Dice the matrix into regions
    uData=createFeatVecs(MIP,nFeats,img_dim1Divisions,img_dim2Divisions);
    uData=uData*tCoeff;%Transform unknown data 
    %imgFeatVec=imgFeatVec*tCoeff;
    
    index=1;
    %Find BMU
    imshow(MIP);
    hold on;
    for i=1:img_dim1Divisions
        for j=1:img_dim2Divisions
            featVec = uData(index,:)';
            clusterIndex=vec2ind(net(featVec));
            
            fprintf("%3d ",clusterIndex);
            [x1,x2,y1,y2] = sectionCorners(i,j,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
            rectangle('Position',[x1,y1,x2-x1,y2-y1],...
                'Curvature',[0,0],...
                'EdgeColor', indexToColor(clusterIndex,som_dim2,som_dim3),...
                'LineWidth', 1,...
                'LineStyle','-')
            index=index+1;
        end
        fprintf("\n");
    end
end