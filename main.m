clear all
close all

font_size=100;

%Load the image
I0 = imread('../Surface Defect Detection/defectdetect/MIPs/MIP5.jpg');
%I0=imread('test_image2.jpg');
%I0=I0(:,1418:4166,:);

%Make a down-scaled version of the image
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

%Scale the Hough Lines
lines11(2,:)=scale_factor*lines11(2,:);
lines22(2,:)=scale_factor*lines22(2,:);
lines11(1,:)=lines11(1,:);
lines22(1,:)=lines22(1,:);
I=I0;
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

%Display these angles in the image
I=insertText(I,[xInts(1,1) yInts(1,1)],ang1,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(1,2) yInts(1,2)],ang2,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(2,1) yInts(2,1)],ang3,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(2,2) yInts(2,2)],ang4,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');

%Calculate the lengths of the sides
line1_length=calc_line_length(line1);
line2_length=calc_line_length(line2);
line3_length=calc_line_length(line3);
line4_length=calc_line_length(line4);

%Display these lengths on the image
l1_l_x=(line1(1,1)+line1(1,2))/2;
l1_l_y=(line1(2,1)+line1(2,2))/2;
l2_l_x=(line2(1,1)+line2(1,2))/2;
l2_l_y=(line2(2,1)+line2(2,2))/2;
l3_l_x=(line3(1,1)+line3(1,2))/2;
l3_l_y=(line3(2,1)+line3(2,2))/2;
l4_l_x=(line4(1,1)+line4(1,2))/2;
l4_l_y=(line4(2,1)+line4(2,2))/2;

I=insertText(I,[l1_l_x l1_l_y],num2str(line1_length,'%2.0f px'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[l2_l_x l2_l_y],num2str(line2_length,'%2.0f px'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[l3_l_x l3_l_y],num2str(line3_length,'%2.0f px'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[l4_l_x l4_l_y],num2str(line4_length,'%2.0f px'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');

%Calculate aspect ratio of MIP
asp_rat = calc_aspect_ratio(line1_length,line2_length,line3_length,...
    line4_length);

% I=insertText(I,[10 10],num2str(asp_rat,'Aspect ratio: %2.2f:1'),...
%     'FontSize',font_size,...
%     'BoxColor','black','TextColor','green');

hold on;

% %Find and isolate the MIP edge
% mip_edge = extract_mip_edge(lines11,lines22,mip_edge);
% mip_edge_coords=calc_edge_positions(mip_edge);
% 
% %Display the MIP edge in the image
% for i=1:size(mip_edge_coords,1)
%    x=mip_edge_coords(i,1);
%    y=mip_edge_coords(i,2);
%    
%    I(y,x,1)=uint8(255);
%    I(y,x,2)=uint8(0);
%    I(y,x,3)=uint8(255);
%    
% end

%Calculate the hough line error
%err=calc_hough_line_err(mip_edge_coords,line1,line2,line3,line4);
%I=insertText(I,[10 200],num2str(err,'Hough line error: %2.2f'),...
%    'FontSize',font_size,...
%    'BoxColor','black','TextColor','green');

imshow(I);

set(line(line1(1,:),line1(2,:),'linewidth',2,'color',[1,0,0]));
set(line(line2(1,:),line2(2,:),'linewidth',2,'color',[0,1,0]));
set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[0,0,1]));
set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));

hold off;
fprintf("Error: %d\n",err);