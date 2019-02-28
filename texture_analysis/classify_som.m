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
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);

if(~exist('uData'))
    fprintf("Creating uData...\n");
    %Dice the matrix into regions
    uData=createFeatVecs(MIP,nFeatures,img_dim1Divisions,img_dim2Divisions);
    %mip_cells=dice(MIP,img_dim1Divisions,img_dim2Divisions);

    uData=uData*tCoeff;%Transform unknown data
end
index=12801;
%Find BMU
imshow(MIP);
hold on;
y1=1;
for i=1:img_dim1Divisions
    x1=1;
    for j=1:img_dim2Divisions
        img_ij=cell2mat(image_cells(index));
        dim1_ij=size(img_ij,1);
        dim2_ij=size(img_ij,2);
        featVec = W(index,:)';%uData(index,:)';
        clusterIndex=vec2ind(net(featVec));
        %clusterIndex=findBMU(featVec',cell2mat(net.IW));
        [in,jn]=ind2sub([som_dim1,som_dim2],clusterIndex);
        if(classifier(in,jn))
            fprintf("%3d ",clusterIndex);
            %[x1,x2,y1,y2] = sectionCorners(i,j,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
             rectangle('Position',[x1,y1,dim2_ij,dim1_ij],...
                'Curvature',[0,0],...
                'EdgeColor', [1,0,0],...
                'LineWidth', 1,...
                'LineStyle','-')
        end
        x1=x1+dim2_ij;
        index=index+1;
    end
    y1=y1+dim1_ij;
    fprintf("\n");
end
%end