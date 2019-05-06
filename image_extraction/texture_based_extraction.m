%Determines what cells are "mip-like"


number_of_image_divs1 = 40;
number_of_image_divs2 = 40;

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
    new_cells = dice(MIP,number_of_image_divs1,number_of_image_divs2);
    neuron_matrix = cell2mat(net.IW);
    %Find BMU
    imshow(MIP);
    hold on;
    distances=zeros(number_of_image_divs1,number_of_image_divs2);
    y1=1;
    for i=1:number_of_image_divs1
        x1=1;
        for j=1:number_of_image_divs2
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
            bmu_distance = norm(neuron_matrix(clusterIndex)-featVec,2);
            distances(i,j)=bmu_distance;
            
            if(bmu_distance>4)
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
    %Retrieve the sets of lines enclosing the MIP in image I
    
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);
    
    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2,1);
    
    %Iterate through all candidate rectangles
    for i=1:size(candidate_rectangles,1)
        i_index=candidate_rectangles(i,1);
        j_index=candidate_rectangles(j,1);
        k_index=candidate_rectangles(k,1);
        l_index=candidate_rectangles(l,1);
        
        candidate_score = candidate_rectangles(i,5);
        if(candidate_score>4)
            
            [xIntersections, yIntersections] = find_intersections(...
                [lines1(:,i_index),lines1(:,j_index)],...
                [lines2(:,k_index),lines2(:,l_index)]);
            
            fprintf("Intersections: \n");
            disp(xIntersections);
            disp(yIntersections);
            %Add up all error from SOM cells within xIntersections
            rectangle_texture_error=0;
            y1=1;
            for j=1:number_of_image_divs1
                x1=1;
                for k=1:number_of_image_divs2
                    img_ij=cell2mat(new_cells(i,j));
                    dim1_ij=size(img_ij,1);
                    dim2_ij=size(img_ij,2);
                    if(inpolygon(x1,y1,xIntersections,yIntersections))
                        fprintf("%d,%d is in rectangle\n",x1,y1);
                        rectangle_texture_error=rectangle_texture_error...
                            +distances(j,k);
                        
                    end
                    x1=x1+dim2_ij;
                    index=index+1;
                end
                y1=y1+dim1_ij;
                fprintf("\n");
            end
            fprintf("Candidate texture error: %f\n",rectangle_texture_error);
            
        else
            fprintf("No good candidate.\n");
        end
    end
    %[lines11,lines22,mip_edge,success] = find_mip(MIP,scale_factor);
    %[xIntersections, yIntersections] = find_intersections(...
    %lines11,lines22);
    
    
    
else
    fprintf("File does not exist.\n");
end