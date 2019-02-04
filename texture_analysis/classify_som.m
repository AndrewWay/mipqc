close all;
% pngFileName = strcat('data/B/MIP5.jpg');
% if exist(pngFileName, 'file')
%
%     %Read into MIP image to matrices
%     I = imread(pngFileName);
%
%     % Find and return the MIP.
%     [MIP]=extract_mip(I);
%
%     %Use the following line if you don't want to extract
%     % MIP=I;
%
%     imageDim1 = size(MIP,1);
%     imageDim2 = size(MIP,2);

%Dice the matrix into regions
uData=createFeatVecs(MIP,nFeatures,img_dim1Divisions,img_dim2Divisions);
mip_cells=dice(MIP,img_dim1Divisions,img_dim2Divisions);

uData=uData*tCoeff;%Transform unknown data

index=1;
%Find BMU
imshow(MIP);
hold on;
for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        featVec = uData(index,:)';
        %clusterIndex=vec2ind(net(featVec));
        clusterIndex=findBMU(featVec',cell2mat(net.IW));
        [in,jn]=ind2sub([som_dim1,som_dim2],neuronIndex)
        if(classifier(in,jn))
            fprintf("%3d ",clusterIndex);
            [x1,x2,y1,y2] = sectionCorners(i,j,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
            rectangle('Position',[x1,y1,x2-x1,y2-y1],...
                'Curvature',[0,0],...
                'EdgeColor', [1,0,0],...
                'LineWidth', 1,...
                'LineStyle','-')
        end
        index=index+1;
    end
    fprintf("\n");
end
%end