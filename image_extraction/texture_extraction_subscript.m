%ONLY RUNS IF TEXTURE_BASED_EXTRACTION.M PREVIOUSLY EXECUTED


%Extraction process
%Retrieve the sets of lines enclosing the MIP in image I

[lines1,lines2] = find_vertical_and_horizontal_lines(I);

[candidate_rectangles] = find_candidate_rectangles(lines1,lines2);

%Iterate through all candidate rectangles
best_rectangle_error=inf;
for i=1:size(candidate_rectangles,1)
    i_index=candidate_rectangles(i,1);
    j_index=candidate_rectangles(i,2);
    k_index=candidate_rectangles(i,3);
    l_index=candidate_rectangles(i,4);
    
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
                if(inpolygon(x1,y1,xIntersections(:),yIntersections(:)))
                   % fprintf("%d,%d is in rectangle\n",x1,y1);
                    rectangle_texture_error=rectangle_texture_error...
                        +distances(j,k);
                    
                end
                x1=x1+dim2_ij;
                index=index+1;
            end
            y1=y1+dim1_ij;
        end
        
        %TODO NORMALIZE ACCORDING TO SIZE OF RECTANGLE
        fprintf("Candidate texture error: %f\n",rectangle_texture_error);
        if(rectangle_texture_error<best_rectangle_error)
            candidate("best 
        end
    else
        fprintf("Candidate rejected; geometry score too low..\n");
    end
end
%[lines11,lines22,mip_edge,success] = find_mip(MIP,scale_factor);
%[xIntersections, yIntersections] = find_intersections(...
%lines11,lines22);