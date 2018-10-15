function [ MIP ] = extract_mip( I0 )
%EXTRACT_MIP Returns the region of an image that contains a MIP

%Rescale the image if necessary. High resolution is not necessary and 
%increases computation time. 
if size(I0,2)>640
    I = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I=I0;
    rescale=0;
end

%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22,mip_edge] = find_mip(I);

% Intersect the outer pair of lines, one from set 1 and one from set 2.
% Output is the x,y coordinates of the intersections:
% xIntersections(i1,i2): x coord of intersection of i1 and i2
% yIntersections(i1,i2): y coord of intersection of i1 and i2

% if(rescale)
%     px1=scale_factor*px1;
%     px2=scale_factor*px2;
%     py1=scale_factor*py1;
%     py2=scale_factor*py2;
%     lines11(2,:)=scale_factor*lines11(2,:);
%     lines22(2,:)=scale_factor*lines22(2,:);
% end

MIP=level_mip(I,lines11,lines22);
figure(1), imshow(I), title('Original');
figure(2), imshow(MIP), title('Rotated');

[xIntersections, yIntersections] = find_intersections(lines11, lines22);

[px1,py1,px2,py2]=find_perfect_vertices(xIntersections,yIntersections);
extracted_mip = extract_rectangle(I,px1,py1,px2,py2);

MIP=level_mip(I0,lines11,lines22);

%MIP=MIP(py1:py2,px1:px2,:);
MIP=extract_rectangle(MIP,px1,py1,px2,py2);

end

