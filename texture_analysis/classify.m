%http://www.ai-junkie.com/ann/som/som4.html
%Each node contains a vector of weights of the same dimension as input vecs


pngFileName = strcat('MIPs/MIP5.jpg');
if exist(pngFileName, 'file')
    
    %Read into MIP image to matrices
    I = imread(pngFileName);
        %!!!!DELETE
        if(k<=10)
            I=I(:,900:3480,:);% DELETE THIS!!
        else
            I=I(:,1485:4090,:);% DELETE THIS!!
        end
        %!!!!
    % Find and return the MIP.
    [MIP]=extractMIP(I);
        
    %Use the following line if you don't want to extract
    %MIP=I;
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    %Dice the matrix into regions
    imgFeatVec=createFeatVecs(MIP,nFeats,img_dim1Divisions,img_dim2Divisions);
  
    
    %Find BMU
    imshow(MIP);
    hold on;
    for i=1:img_dim1Divisions
        for j=1:img_dim2Divisions
            featVec = imgFeatVec(:,i,j);
            clusterIndex=vec2ind(net(featVec));
            
            fprintf("%3d ",clusterIndex);
            [x1,x2,y1,y2] = sectionCorners(i,j,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
            rectangle('Position',[x1,y1,x2-x1,y2-y1],...
                'Curvature',[0,0],...
                'EdgeColor', indexToColor(clusterIndex,som_dim2,som_dim3),...
                'LineWidth', 1,...
                'LineStyle','-')
        end
        fprintf("\n");
    end


end
