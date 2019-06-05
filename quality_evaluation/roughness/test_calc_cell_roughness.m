%Rescale the image if necessary. High resolution is not necessary and
%increases computation time.
clear all
close all


I = imread('data/D_raw/_MG_6884.png');
gray_I=rgb2gray(I);
otsu_thresh=graythresh(gray_I);
E = edge(gray_I,'canny',otsu_thresh);


mip_edge_coords=calc_edge_positions(E);
edge_size=size(mip_edge_coords,1);

%Add mip edge to image
for i=1:size(mip_edge_coords,1)
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    
    I(y,x,1)=uint8(255);
    I(y,x,2)=uint8(0);
    I(y,x,3)=uint8(255);
    
end

qi=[2410;1593];
qip1=[2562;1985];

[roughness,p1,p2,p3,p4]=calc_cell_roughness(qi,qip1,E,300);
I=insertShape(I,'Line',[qi(1,1),qi(2,1),qip1(1,1),qip1(2,1)],'Color','red');
I=insertShape(I,'Line',[p1(1,1),p1(2,1),p2(1,1),p2(2,1)]);
I=insertShape(I,'Line',[p2(1,1),p2(2,1),p4(1,1),p4(2,1)]);
I=insertShape(I,'Line',[p4(1,1),p4(2,1),p3(1,1),p3(2,1)]);
I=insertShape(I,'Line',[p3(1,1),p3(2,1),p1(1,1),p1(2,1)]);
imshow(I)