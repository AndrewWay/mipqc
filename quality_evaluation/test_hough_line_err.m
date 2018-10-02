%Rescale the image if necessary. High resolution is not necessary and 
%increases computation time. 
clear all
close all


I0 = imread('test_image2.jpg');

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

[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];


err=calc_hough_line_err(mip_edge,line1,line2,line3,line4);

ang1=calc_angle_of_intersection(lines11(:,1),lines22(:,1));
ang2=calc_angle_of_intersection(lines11(:,1),lines22(:,2));
ang3=calc_angle_of_intersection(lines11(:,2),lines22(:,1));
ang4=calc_angle_of_intersection(lines11(:,2),lines22(:,2));


I=insertText(I,[xInts(1,1) yInts(1,1)],ang1,'FontSize',18,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(1,2) yInts(1,2)],ang2,'FontSize',18,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(2,1) yInts(2,1)],ang3,'FontSize',18,...
    'BoxColor','black','TextColor','white');
I=insertText(I,[xInts(2,2) yInts(2,2)],ang4,'FontSize',18,...
    'BoxColor','black','TextColor','white');
hold on;
imshow(I);
imshow(mip_edge);
set(line(line1(1,:),line1(2,:),'linewidth',2,'color',[1,0,0]));
set(line(line2(1,:),line2(2,:),'linewidth',2,'color',[0,1,0]));
set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[0,0,1]));
set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));

hold off;
fprintf("Error: %d\n",err);