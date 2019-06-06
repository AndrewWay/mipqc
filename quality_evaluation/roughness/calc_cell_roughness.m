function [ roughness,p1,p2,p3,p4,n_edge_points ] = calc_cell_roughness(qi,qip1,edge,a)
%CALC_CELL_ROUGHNESS Calculates average distance of edge points from middle
%of box
%Extract the points
xi=qi(1,1);
yi=qi(2,1);
xip1=qip1(1,1);
yip1=qip1(2,1);

%Find theta, the angle component of the Hough line connecting the qi and
%q+1
m=(yip1-yi)/(xip1-xi);
%Apparently making this negative makes everything work??
%if the boxes are skewed (not rectangular) check this th
th=-1*(pi/2-atan(m));

%Find the points above and below the line that form the box's vertices
[p1,p2]=calc_search_vertices( qi,th,a );
[p3,p4]=calc_search_vertices( qip1,th,a );

x_vertices=[p1(1,1),p2(1,1),p4(1,1),p3(1,1),p1(1,1)];
y_vertices=[p1(2,1),p2(2,1),p4(2,1),p3(2,1),p1(2,1)];

% plot(x_vertices,y_vertices);
% pause;

max_x=max(x_vertices);
min_x=min(x_vertices);
max_y=max(y_vertices);
min_y=min(y_vertices);

mip_edge = edge(min_y:max_y,min_x:max_x);

% imshow(mip_edge);
% pause;

mip_edge_coords=calc_edge_positions(mip_edge);
mip_edge_coords(:,1)=mip_edge_coords(:,1)+min_x;
mip_edge_coords(:,2)=mip_edge_coords(:,2)+min_y;


edge_size=size(mip_edge_coords,1);


roughness=0;
n_edge_points=0;

for i=1:edge_size
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    %Check which edge pixels are within the polygon
    if(inpolygon(x,y,x_vertices,y_vertices))
        %Calculate the pixels distance from the midline of the box
        roughness=roughness+distance(qi,qip1,[x;y]);
        n_edge_points=n_edge_points+1;
        
    end
end

if(n_edge_points>0)
    roughness=roughness/n_edge_points;
else
    %disp("no edge points in box");
end
end

