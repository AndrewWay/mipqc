clear all
close all


min_grade=0.7;
max_grade=1-min_grade;

I = imread('data/D_raw/_MG_6884.png');

%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22] = find_mip(I);
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

[r1,e1]=calc_roughness_array([line1(1,1);line1(1,2)],[line1(2,1);line1(2,2)],mip_edge);
%[r2,e2]=calc_roughness_array([line2(1,1);line2(1,2)],[line2(1,2);line2(2,2)],mip_edge);
%[r3,e3]=calc_roughness_array([line3(1,1);line3(1,2)],[line3(1,2);line3(2,2)],mip_edge);
%[r4,e4]=calc_roughness_array([line4(1,1);line4(1,2)],[line4(1,2);line4(2,2)],mip_edge);

for i=1:size(r1,1)-1
    qi=e1(i,:);
    qi=[qi(1,1);qi(1,2)];
    
    qip1=e1(i+1,:);
    qip1=[qip1(1,1);qip1(1,2)];
    
    m=(e1(i+1,2)-e1(i,2))/(e1(i+1,1)-e1(i,1));
    th=atan(m);
    
    %Calculate the vertices
    [p1,p2]=calc_search_vertices(qi,th,300);
    [p3,p4]=calc_search_vertices(qip1,th,300);
    
    I=insertShape(I,'Line',[p1(1,1),p1(2,1),p2(1,1),p2(2,1)]);
    I=insertShape(I,'Line',[p2(1,1),p2(2,1),p3(1,1),p3(2,1)]);
    I=insertShape(I,'Line',[p3(1,1),p3(2,1),p4(1,1),p4(2,1)]);
    I=insertShape(I,'Line',[p4(1,1),p4(2,1),p1(1,1),p1(2,1)]);
    
end

imshow(I);

