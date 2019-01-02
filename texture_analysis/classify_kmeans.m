pngFileName = strcat('data/B/MIP5.jpg');
if exist(pngFileName, 'file')
    
    %Read into MIP image to matrices
    I = imread(pngFileName);
    
    [MIP]=extract_mip(I);
    
    %Use the following line if you don't want to extract
    % MIP=I;
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    %Dice the matrix into regions
    uData=createFeatVecs(MIP,nFeatures,img_dim1Divisions,img_dim2Divisions);
    uData=zscore(uData);%Uncomment this line to Zscore the unknown data.
    uData=uData*tCoeff;%Transform unknown data
    index=1;
    %Find BMU
    figure(2), imshow(MIP);
    hold on;
    for i=1:img_dim1Divisions
        for j=1:img_dim2Divisions
            featVec = uData(index,:);
%            clusterIndex=vec2ind(net(featVec));
            
            %Determine which centroid the cell is closed to
            d1=norm(featVec-[C(1,1),C(1,2)]);
            d2=norm(featVec-[C(2,1),C(2,2)]);
            d3=norm(featVec-[C(3,1),C(3,2)]);
            d4=norm(featVec-[C(4,1),C(4,2)]);
            [val,minidx]=min([d1,d2,d3,d4]);
            if(minidx==1)
                boxColor=[1,0,0];
            elseif(minidx==2)
                boxColor=[0,1,0];
            elseif(minidx==3)
                boxColor=[0,0,1];
            else
                boxColor=[1,1,0];
            end
            fprintf("%d ",minidx);
            [x1,x2,y1,y2] = sectionCorners(i,j,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
            rectangle('Position',[x1,y1,x2-x1,y2-y1],...
                'Curvature',[0,0],...
                'EdgeColor', boxColor,...
                'LineWidth', 1,...
                'LineStyle','-')
            index=index+1;
        end
        fprintf("\n");
    end
else
    fprintf("File does not exist\n");
end