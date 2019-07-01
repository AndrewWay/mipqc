%Determines what cells are "mip-like"

close all;

output_identifier="good";

good_index=6887;
bad_index=6894;
ugly_index=6875;

if(strcmp(output_identifier,"good"))
    mip_index=good_index;
end

if(strcmp(output_identifier,"bad"))
    mip_index=bad_index;
end 

if(strcmp(output_identifier,"ugly"))
    mip_index=ugly_index;
end

cr2FileName = strcat('data/D_raw/_MG_', num2str(mip_index), '.CR2');
output_file_path = strcat('results/', output_identifier, '/',output_identifier);

pause_figure=1;

if exist(cr2FileName, 'file')
    %Read into MIP image to matrices
    I = imread(cr2FileName);

    I=remove_ruler(I);
    I = I(:,2000:end,:);    
    
    %ORIGINAL IMAGE
    figure(1),imshow(I);
    pause;
    imwrite(I, sprintf('%s_original.jpg',output_identifier),'jpg');
    %Find the four lines
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);

    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);

    %IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
    candidate_rectangles=sortrows(candidate_rectangles,5);
    
    best_rectangle = candidate_rectangles(end,1:4);
    lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
    lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
    
    %False edge edge detection
    [lines11,lines22]=trim_edges(lines11,lines22,I);
    
    I_rectangle = draw_lines(lines11,lines22,I);
    disp("filtered");
    figure(1),imshow(I_rectangle);
    pause;
    imwrite(I_rectangle, sprintf('%s_rectangle.jpg',output_identifier),'jpg');
    %IMAGE WITH GEOMETRIC PROPERTY OVERLAY
    I_geometry = create_geometry_overlay(I,lines11,lines22);
    figure(1),imshow(I_geometry);
    pause;
    imwrite(I_geometry, sprintf('%s_geometry.jpg',output_identifier),'jpg');
    %IMAGE WITH CLASSIFIED TEXTURE
    %TODO move to function
        [rectangle_xInts,rectangle_yInts]=find_intersections(lines11,lines22);
    rectangle_xInts=[rectangle_xInts(:,1);rectangle_xInts(:,2)];
    rectangle_yInts=[rectangle_yInts(:,1);rectangle_yInts(:,2)];
    %Find convex hull from the intercepts
    int_order=convhull(rectangle_xInts,rectangle_yInts);
    
    rectangle_xInts=rectangle_xInts(int_order);
    rectangle_yInts=rectangle_yInts(int_order)
    plot(rectangle_xInts,rectangle_yInts)
    pause;
    close all;
    %MIP=extract_mip(I);
    %MIP=I;
    MIP=I_rectangle;
    figure(1),imshow(MIP);
    
    pause;
    
    
    imageDim1 = size(MIP,1);
    imageDim2 = size(MIP,2);

    index=1;
    new_cells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
    

    %Find BMU
    y1=1;
    for i=1:img_dim1Divisions
        x1=1;
        for j=1:img_dim2Divisions
            img_ij=cell2mat(new_cells(i,j));
            
            dim1_ij=size(img_ij,1);
            dim2_ij=size(img_ij,2);
            
            cell_center_x=x1+dim2_ij/2;
            cell_center_y=y1+dim1_ij/2;
            
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
            
%             if(find_scrapes(img_ij)==1&&inpolygon(cell_center_x,cell_center_y,...
%                     rectangle_xInts,rectangle_yInts))

           if(classifier(in,jn)>0&&inpolygon(cell_center_x,cell_center_y,...
                   rectangle_xInts,rectangle_yInts))
                rectangle('Position',[x1,y1,dim2_ij,dim1_ij],...
                    'Curvature',[0,0],...
                    'EdgeColor', 'r',...%classLabelToColor(classifier(in,jn))/255,...
                    'LineWidth', 1,...
                    'LineStyle','-')
            end
           
            x1=x1+dim2_ij;
            index=index+1;
        end
        y1=y1+dim1_ij;
        fprintf("\n");
    end
    minimize_white_space
    saveas(gcf,sprintf('%s_texture.jpg',output_identifier));
else
    fprintf("CR2 File does not exist.\n");
end