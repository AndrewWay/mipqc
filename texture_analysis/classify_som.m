close all;
pngFileName = strcat('data/D/D6943.png');
if exist(pngFileName, 'file')
    
    %Read into MIP image to matrices
    I = imread(pngFileName);
    
    % Find and return the MIP.
    %[MIP]=extract_mip(I);
    %figure(1),imshow(MIP);
    figure(2),imshow(I);
    pause;
    close all;
    %Use the following line if you don't want to extract
    MIP=I;
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    fprintf("Creating uData...\n");

    index=1;
    new_cells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
    
    %Find BMU
    imshow(MIP);
    hold on;
    y1=1;
    for i=1:img_dim1Divisions1
        x1=1;
        for j=1:img_dim1Divisions2
            img_ij=cell2mat(new_cells(i,j));
            
            dim1_ij=size(img_ij,1);
            dim2_ij=size(img_ij,2);
 
                
            featVec = create_feature_vector(img_ij,nFeatures);
            %MUST ZSCORE THIS DATA TO MATCH ZDATA (refer to loadData.m)
            featVec=(featVec-zmu)./zsigma;
            featVec = featVec*tCoeff;
            clusterIndex=vec2ind(net(featVec'));
%             if(i==38&&j==1)
%                figure(3),imshow(img_ij);
%                disp(clusterIndex);
%                pause;
%             end
            %clusterIndex=findBMU(featVec',cell2mat(net.IW));
            [in,jn]=ind2sub([som_dim1,som_dim2],clusterIndex);
            if(classifier(in,jn))
                fprintf("%3d ",clusterIndex);
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
end