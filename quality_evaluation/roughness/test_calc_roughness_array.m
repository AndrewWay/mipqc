clear all
close all


min_grade=0.7;
max_grade=1-min_grade;

I = imread('data/D_raw/_MG_6884.png');

%Retrieve the sets of lines enclosing the MIP in image I
I=remove_ruler(I);
I = I(:,2000:end,:);

%ORIGINAL IMAGE
figure(1),imshow(I);
pause;

%Find the four lines
[lines1,lines2] = find_vertical_and_horizontal_lines(I);

[candidate_rectangles] = find_candidate_rectangles(lines1,lines2);

%IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
candidate_rectangles=sortrows(candidate_rectangles,5);

best_rectangle = candidate_rectangles(end,1:4);
lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
%lines11: mostly vertical
%lines22: mostly horizontal

[xInts,yInts] = find_intersections(lines11,lines22);

%Calculate coordinates of mip edge
gray_I=rgb2gray(I);
otsu_thresh=graythresh(gray_I);
mip_edge = edge(gray_I,'canny',otsu_thresh);

mip_edge_coords=calc_edge_positions(mip_edge);
edge_size=size(mip_edge_coords,1);

%Add mip edge to image
for i=1:size(mip_edge_coords,1)
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    
    I(y,x,1)=uint8(255);
    I(y,x,2)=uint8(0);
    I(y,x,3)=uint8(255);
    
end





line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];%1st vertical
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];%1st horizontal
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];%2nd vertical
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];%2nd horizontal

I=draw_lines(lines11,lines22,I);

a=100;

[end_points]=segment_line([line1(1,1);line1(1,2)],[line1(2,1);line1(2,2)],30);

for i=1:size(end_points,1)-1
    qi=end_points(i,:);
    qi=[qi(1,1);qi(1,2)];
    
    qip1=end_points(i+1,:);
    qip1=[qip1(1,1);qip1(1,2)];
    
    [roughness,p1,p2,p3,p4]=calc_cell_roughness(qi,qip1,mip_edge,a);
    
    
    I=insertShape(I,'Line',[qi(1,1),qi(2,1),qip1(1,1),qip1(2,1)],'Color','red');
    I=insertShape(I,'Line',[p1(1,1),p1(2,1),p2(1,1),p2(2,1)]);
    I=insertShape(I,'Line',[p2(1,1),p2(2,1),p4(1,1),p4(2,1)]);
    I=insertShape(I,'Line',[p4(1,1),p4(2,1),p3(1,1),p3(2,1)]);
    I=insertShape(I,'Line',[p3(1,1),p3(2,1),p1(1,1),p1(2,1)]);
    
end

imshow(I);