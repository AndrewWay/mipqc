%ONLY RUNS IF TEXTURE_BASED_EXTRACTION.M PREVIOUSLY EXECUTED

close all;
%PARAMETERS


%Iterate through all candidate rectangles
best_rectangle_error=inf;
best_candidate=-1;
for i=1:size(candidate_rectangles,1)
    i_index=candidate_rectangles(i,1);
    j_index=candidate_rectangles(i,2);
    k_index=candidate_rectangles(i,3);
    l_index=candidate_rectangles(i,4);
    
    candidate_score = candidate_rectangles(i,5);
    n_cells_in_candidate_rectangle=0;
    if(candidate_score>3)
        
        [xIntersections, yIntersections] = find_intersections(...
            [lines1(:,i_index),lines1(:,j_index)],...
            [lines2(:,k_index),lines2(:,l_index)]);
        
        % fprintf("Intersections: \n");
        % disp(xIntersections);
        % disp(yIntersections);
        %Add up all error from SOM cells within xIntersections
        candidate_rectangle_size=0;
        rectangle_texture_error=0;
        y1=1;
        for j=1:number_of_image_divs1
            x1=1;
            for k=1:number_of_image_divs2
                img_ij=cell2mat(new_cells(j,k));
                dim1_ij=size(img_ij,1);
                dim2_ij=size(img_ij,2);
                if(inpolygon(x1,y1,xIntersections(:),yIntersections(:)))

                    rectangle_texture_error=rectangle_texture_error+error_matrix(j,k);
                    candidate_rectangle_size=candidate_rectangle_size+dim1_ij*dim2_ij;
                    n_cells_in_candidate_rectangle=n_cells_in_candidate_rectangle+1;
                end
                x1=x1+dim2_ij;
            end
            y1=y1+dim1_ij;
        end
        
        %TODO NORMALIZE ACCORDING TO SIZE OF RECTANGLE
        
        
        rectangle_texture_error=rectangle_texture_error/candidate_rectangle_size;
        
        total_candidate_error = geometry_error_weight*(6-candidate_rectangles(i,5))/6+texture_error_weight*rectangle_texture_error;
        
        
        fprintf("Candidate texture error: %f\n",rectangle_texture_error);
        if(total_candidate_error<best_rectangle_error)
            fprintf("New best candidate found.\n");
            best_candidate=i;
            best_rectangle_error=total_candidate_error;
        end
        
        
        %DELETE FOLLOWING IF BLOCK AT SOME POINT
        if(best_candidate>0)
            iopt=candidate_rectangles(best_candidate,1);
            jopt=candidate_rectangles(best_candidate,2);
            kopt=candidate_rectangles(best_candidate,3);
            lopt=candidate_rectangles(best_candidate,4);
            first_line=lines1(:,iopt);
            sec_line=lines1(:,jopt);
            third_line=lines2(:,kopt);
            fourth_line=lines2(:,lopt);
            
    %        figure(1),imshow(draw_lines([first_line,sec_line],[third_line,fourth_line],I));
            
            %close all;
        end
        iopt=candidate_rectangles(i,1);
        jopt=candidate_rectangles(i,2);
        kopt=candidate_rectangles(i,3);
        lopt=candidate_rectangles(i,4);
        first_line=lines1(:,iopt);
        sec_line=lines1(:,jopt);
        third_line=lines2(:,kopt);
        fourth_line=lines2(:,lopt);
        
 %       figure(2),imshow(draw_lines([first_line,sec_line],[third_line,fourth_line],I));
 %       pause;
        %close all;
        %DELETE ABOVE
    else
        % fprintf("Candidate rejected; geometry score too low..\n");
    end
end


iopt=candidate_rectangles(best_candidate,1);
jopt=candidate_rectangles(best_candidate,2);
kopt=candidate_rectangles(best_candidate,3);
lopt=candidate_rectangles(best_candidate,4);
first_line=lines1(:,iopt);
sec_line=lines1(:,jopt);
third_line=lines2(:,kopt);
fourth_line=lines2(:,lopt);

imshow(draw_lines([first_line,sec_line],[third_line,fourth_line],I));

