%Runs through specified MIP images and evaluates each film's geometry


close all;

output_identifier="ugly";

starting_index=6887;
ending_index=6890;

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
        
        %Find the four lines
        [lines1,lines2] = find_vertical_and_horizontal_lines(I);
        
        [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);
        
        %IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
        candidate_rectangles=sortrows(candidate_rectangles,5);
        
        best_rectangle = candidate_rectangles(end,1:4);
        lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
        lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
        
        
        
        [xInts,yInts] = find_intersections(lines11,lines22);
        
        line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
        line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
        line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
        line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];
        
        %Find the angles of intersection of the lines
        ang1=calc_angle_of_intersection(lines11(:,1),lines22(:,1));
        ang2=calc_angle_of_intersection(lines11(:,1),lines22(:,2));
        ang3=calc_angle_of_intersection(lines11(:,2),lines22(:,1));
        ang4=calc_angle_of_intersection(lines11(:,2),lines22(:,2));
        
        %Calculate the lengths of the sides
        line1_length=pixel_to_mm(calc_line_length(line1));
        line2_length=pixel_to_mm(calc_line_length(line2));
        line3_length=pixel_to_mm(calc_line_length(line3));
        line4_length=pixel_to_mm(calc_line_length(line4));
        
        %IMAGE WITH GEOMETRIC PROPERTY OVERLAY
%         I_geometry = create_geometry_overlay(I,lines11,lines22);
%         figure(1),imshow(I_geometry);
%         pause;
%         imwrite(I_geometry, sprintf('%s_geometry.jpg',output_identifier),'jpg');
%       
        %Calculate edge roughness for each side
        
    else
        fprintf("CR2 File does not exist.\n");
    end
end