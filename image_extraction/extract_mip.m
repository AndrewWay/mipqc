function [ extracted_mip ] = extract_mip( I0 )
%EXTRACT_MIP Returns the region of an image that contains a MIP

%Rescale the image if necessary. High resolution is not necessary and 
%increases computation time. 
if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    scale_factor=1;
    rescale=0;
end

%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22,mip_edge,success] = find_mip(I,scale_factor);
%draw_lines(lines11,lines22,I);
if(success)


% Intersect the outer pair of lines, one from set 1 and one from set 2.
% Output is the x,y coordinates of the intersections:
% xIntersections(i1,i2): x coord of intersection of i1 and i2
% yIntersections(i1,i2): y coord of intersection of i1 and i2


%Scale the Hough Lines
scaled_lines11(2,:)=scale_factor*lines11(2,:);
scaled_lines22(2,:)=scale_factor*lines22(2,:);
scaled_lines11(1,:)=lines11(1,:);
scaled_lines22(1,:)=lines22(1,:);

%draw_lines(scaled_lines11,scaled_lines22,I0);
%pause;
%Level the MIP and the Hough lines
[leveled_I0,leveled_scaled_lines11,leveled_scaled_lines22]=...
    level_mip(I0,...
    scaled_lines11,...
    scaled_lines22);

%figure(1), imshow(I0), title('Original');
%figure(2), imshow(leveled_I0), title('Rotated');
%pause;
% fprintf("Displaying figure at extract_mip, line 43\n");
% figure(1), imshow(draw_lines(leveled_scaled_lines11,...
%     leveled_scaled_lines22,leveled_I0));
% pause;

close(figure(1));
[xIntersections, yIntersections] = find_intersections(...
    leveled_scaled_lines11,...
    leveled_scaled_lines22);

[px1,py1,px2,py2]=find_perfect_vertices(xIntersections,yIntersections);

%Extract the scaled, leveled MIP
extracted_mip = extract_rectangle(leveled_I0,px1,py1,px2,py2);

else
    extracted_mip=0;
end

end

