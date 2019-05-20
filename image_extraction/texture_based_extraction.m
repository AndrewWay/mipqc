%Determines what cells are "mip-like"

<<<<<<< HEAD
=======



>>>>>>> 1baf0ee87a89db5a7cccc9f274107822bdfde0c2
close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    
    %     %Read into MIP image to matrices
    I = imread(pngFileName);
    %
    %     % Find and return the MIP.
    %     %[MIP]=extract_mip(I);
<<<<<<< HEAD
    MIP=I;
    figure(1),imshow(MIP);
=======
    I=remove_ruler(I);
    figure(1),imshow(I);
>>>>>>> 1baf0ee87a89db5a7cccc9f274107822bdfde0c2
    
    pause;
    close all;
    %Use the following line if you don't want to extract
    
<<<<<<< HEAD
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);
    
    fprintf("Creating uData...\n");
    
    index=1;
    new_cells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
    neuron_matrix = cell2mat(net.IW);
    %Find BMU
    imshow(MIP);
    hold on;
    distances=zeros(img_dim1Divisions,img_dim2Divisions);
    y1=1;
    for i=1:img_dim1Divisions
        x1=1;
        for j=1:img_dim2Divisions
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
            distances=[distances;bmu_distance];
            
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
    
=======
    number_of_image_divs1=60;
    number_of_image_divs2=60;
    texture_error_weight=2;
    geometry_error_weight=2;
    
    
    
    new_cells = dice(I,number_of_image_divs1,number_of_image_divs2);
    
    error_matrix = create_error_matrix(new_cells,net,nFeatures,zmu,zsigma,tCoeff);
    total_texture_error=sum(error_matrix(:));
    %Retrieve the sets of lines enclosing the MIP in image I
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);
    
    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);
    
    texture_extraction_subscript
>>>>>>> 1baf0ee87a89db5a7cccc9f274107822bdfde0c2
    
else
    fprintf("File does not exist.\n");
end