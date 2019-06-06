%Runs through specified MIP images and evaluates each film's geometry

clear all;
close all;


starting_index=6858;
ending_index=7008;

%values being collected:
%index,internal angles,side lengths,Edge roughnesses,
geometries=[];

for mip_index=starting_index:ending_index
    cr2FileName = strcat('data/D_raw/_MG_', num2str(mip_index), '.CR2');
    output_identifier=num2str(mip_index);
    output_file_path = strcat('results/geometries/',output_identifier);
    
    pause_figure=1;
    
    if exist(cr2FileName, 'file')
        %Read into MIP image to matrices
        I = imread(cr2FileName);
        
        I=remove_ruler(I);
        I = I(:,2000:end,:);
        %Calculate coordinates of mip edge
        gray_I=rgb2gray(I);
        otsu_thresh=graythresh(gray_I);
        mip_edge = edge(gray_I,'canny',otsu_thresh);
        
        %Find the four lines
        [lines1,lines2] = find_vertical_and_horizontal_lines(I);
        
        [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);
        if(size(candidate_rectangles,1)>0)
            %IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
            candidate_rectangles=sortrows(candidate_rectangles,5);
            
            best_rectangle = candidate_rectangles(end,1:4);
            lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
            lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
            
            
            I_rectangle = draw_lines(lines11,lines22,I);
            [xInts,yInts] = find_intersections(lines11,lines22);
            
            surface_area=calc_surface_area(xInts,yInts);
            
            line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
            line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
            line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
            line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];
            
            %Find the angles of intersection of the lines
            ang1=calc_angle_of_intersection(lines11(:,1),lines22(:,1));
            ang2=calc_angle_of_intersection(lines11(:,1),lines22(:,2));
            ang3=calc_angle_of_intersection(lines11(:,2),lines22(:,1));
            ang4=calc_angle_of_intersection(lines11(:,2),lines22(:,2));
            
            average_angle=(ang1+ang2+ang3+ang4)/4;
            std_angle=std([ang1,ang2,ang3,ang4]);
            
            %Calculate the lengths of the sides
            line1_length=pixel_to_mm(calc_line_length(line1));
            line2_length=pixel_to_mm(calc_line_length(line2));
            line3_length=pixel_to_mm(calc_line_length(line3));
            line4_length=pixel_to_mm(calc_line_length(line4));
            
            %Calculate aspect ratio
            aspect_ratio=calc_aspect_ratio(line1_length,line2_length,...
                line3_length,line4_length);
            
            %Calculate edge roughness for each side
            [rough_cells,weak_cells,n_cells]=evaluate_edge(lines11,lines22,mip_edge);
            
            edge_roughness=size(rough_cells,2)/n_cells;
            edge_weakness=size(weak_cells,2)/n_cells;
            %Create values to store
            
            geometries=[geometries;
                mip_index,surface_area,aspect_ratio,average_angle,std_angle,...
                edge_roughness,edge_weakness];
            
            if(aspect_ratio>3)
                fprintf("MIP%d has an abnormally high aspect ratio\n");
                figure(1),imshow(I_rectangle);
                pause;
            end
            if(surface_area>280)
                fprintf("MIP%d has an abnormally large surface area\n");
                figure(1),imshow(I_rectangle);
                pause;
            end
            if(surface_area<100)
                fprintf("MIP%d has an abnormally low surface area\n");
                figure(1),imshow(I_rectangle);
                pause;
            end
        else
            fprintf("No candidate rectangles for MIP%d could be found.\n",mip_index);
            figure(1),imshow(I);
            pause;
        end
    else
        fprintf("CR2 File does not exist.\n");
    end
end