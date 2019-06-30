function [ I_overlayed] = create_geometry_overlay( I,lines11,lines22)
%CREATE_GEOMETRY_OVERLAY Summary of this function goes here
%   Detailed explanation goes here
font_size=100;

I_overlayed=I;
[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];

%Find the angles of intersection of the lines
ang1=calc_angle_of_intersection(lines11(:,1),lines22(:,1),lines11(:,2),lines22(:,2));
ang2=calc_angle_of_intersection(lines11(:,1),lines22(:,2),lines11(:,2),lines22(:,1));
ang3=calc_angle_of_intersection(lines11(:,2),lines22(:,1),lines11(:,1),lines22(:,2));
ang4=calc_angle_of_intersection(lines11(:,2),lines22(:,2),lines11(:,1),lines22(:,1));

%Display these angles in the image
I_overlayed=insertText(I_overlayed,[xInts(1,1) yInts(1,1)],ang1,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[xInts(1,2) yInts(1,2)-200],ang2,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[xInts(2,1)-200 yInts(2,1)],ang3,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[xInts(2,2)-200 yInts(2,2)-200],ang4,'FontSize',font_size,...
    'BoxColor','black','TextColor','white');


%Calculate the lengths of the sides
line1_length=pixel_to_mm(calc_line_length(line1));
line2_length=pixel_to_mm(calc_line_length(line2));
line3_length=pixel_to_mm(calc_line_length(line3));
line4_length=pixel_to_mm(calc_line_length(line4));

%Display these lengths on the image
l1_l_x=(line1(1,1)+line1(1,2))/2;
l1_l_y=(line1(2,1)+line1(2,2))/2;
l2_l_x=(line2(1,1)+line2(1,2))/2;
l2_l_y=(line2(2,1)+line2(2,2))/2;
l3_l_x=(line3(1,1)+line3(1,2))/2;
l3_l_y=(line3(2,1)+line3(2,2))/2;
l4_l_x=(line4(1,1)+line4(1,2))/2;
l4_l_y=(line4(2,1)+line4(2,2))/2;

I_overlayed=insertText(I_overlayed,[l1_l_x l1_l_y],num2str(line1_length,'%2.0f mm'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[l2_l_x l2_l_y],num2str(line2_length,'%2.0f mm'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[l3_l_x-400 l3_l_y],num2str(line3_length,'%2.0f mm'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');
I_overlayed=insertText(I_overlayed,[l4_l_x l4_l_y-200],num2str(line4_length,'%2.0f mm'),'FontSize',font_size,...
    'BoxColor','black','TextColor','white');

%Calculate aspect ratio of MIP
asp_rat = calc_aspect_ratio(line1_length,line2_length,line3_length,...
    line4_length);

% I_overlayed=insertText(I_overlayed,[10 10],num2str(asp_rat,'Aspect ratio: %2.2f:1'),...
%     'FontSize',font_size,...
%     'BoxColor','black','TextColor','green');

%set(line(line1(1,:),line1(2,:),'linewidth',2,'color',[1,0,0]));
%set(line(line2(1,:),line2(2,:),'linewidth',2,'color',[0,1,0]));
%set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[0,0,1]));
%set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));


I_overlayed = insertShape(I_overlayed,'Line',[line1(1,1) line1(2,1) line1(1,2) line1(2,2)],'LineWidth',15,'Color','red');
I_overlayed = insertShape(I_overlayed,'Line',[line2(1,1) line2(2,1) line2(1,2) line2(2,2)],'LineWidth',15,'Color','green');
I_overlayed = insertShape(I_overlayed,'Line',[line3(1,1) line3(2,1) line3(1,2) line3(2,2)],'LineWidth',15,'Color','blue');
I_overlayed = insertShape(I_overlayed,'Line',[line4(1,1) line4(2,1) line4(1,2) line4(2,2)],'LineWidth',15,'Color','yellow');

end

