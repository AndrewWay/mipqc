%Determines what cells are "mip-like"

close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    
    %     %Read into MIP image to matrices
    I = imread(pngFileName);
    %
    %     % Find and return the MIP.
    %     %[MIP]=extract_mip(I);
    MIP=I;
    figure(1),imshow(MIP);
    
    pause;
    close all;
    %Use the following line if you don't want to extract
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    fprintf("Creating uData...\n");
    
    index=1;
    img_dim1Divs=80;
    img_dim2Divs=80;
    new_cells = dice(MIP,img_dim1Divs,img_dim2Divs);
    neuron_matrix = cell2mat(net.IW);
    %Find BMU
    imshow(MIP);
    hold on;
    distances=zeros(img_dim1Divs,img_dim2Divs);
    y1=1;
    for i=1:img_dim1Divs
        x1=1;
        for j=1:img_dim2Divs
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
            bmu_distance = norm(neuron_matrix(clusterIndex)-featVec);
            %You may plot the distances matrix as a contour plot.
            distances(i,j)=bmu_distance;
            
            if(bmu_distance>4)
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
    
    
    
    
    %Extraction process
    
    
else
    fprintf("File does not exist.\n");
end