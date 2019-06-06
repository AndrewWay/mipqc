clear all
close all

I = imread('data/D_raw/_MG_6884.png');

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


%Calculate coordinates of mip edge
gray_I=rgb2gray(I);
otsu_thresh=graythresh(gray_I);
mip_edge = edge(gray_I,'canny',otsu_thresh);

mip_edge_coords=calc_edge_positions(mip_edge);
edge_size=size(mip_edge_coords,1);


I=draw_lines(lines11,lines22,I);

[rough_cells,weak_cells,n_cells,dl]=evaluate_edge(lines11,lines22,mip_edge);

%Insert weak cells on image
for i=1:size(weak_cells,2)
    cell_center=weak_cells(:,i);
    I=insertShape(I,'circle',[cell_center(1,1) cell_center(2,1) dl/2],...
        'LineWidth',3,'Color','Cyan');
end

%insert rough cells on image
for i=1:size(rough_cells,2)
    cell_center=rough_cells(:,i);
    I=insertShape(I,'Rectangle',[cell_center(1,1)-dl/2 cell_center(2,1)-dl/2 dl dl],...
        'LineWidth',3,'Color','Red');
end

%Add mip edge to image
for i=1:size(mip_edge_coords,1)
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    
    I(y,x,1)=uint8(255);
    I(y,x,2)=uint8(0);
    I(y,x,3)=uint8(255);
    
end

imshow(I);