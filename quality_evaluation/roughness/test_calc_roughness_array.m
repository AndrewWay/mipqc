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


figure(1), imshow(I)