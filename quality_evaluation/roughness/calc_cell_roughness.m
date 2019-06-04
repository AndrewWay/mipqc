function [ roughness,p1,p2,p3,p4 ] = calc_cell_roughness(qi,qip1,edge,I)
%CALC_CELL_ROUGHNESS Calculates average distance of edge points from middle
%of box
%Set the box search height
a=300;

%Extract the points
xi=qi(1,1);
yi=qi(2,1);
xip1=qip1(1,1);
yip1=qip1(2,1);

%Find theta, the angle component of the Hough line connecting the qi and
%q+1
m=(yip1-yi)/(xip1-xi);
th=atan(m);

%Find the points above and below the line that form the box's vertices
[p1,p2]=calc_search_vertices( qi,th,a );
[p3,p4]=calc_search_vertices( qip1,th,a );

x_vertices=[p1(1,1),p2(1,1),p4(1,1),p3(1,1),p1(1,1)];
y_vertices=[p1(2,1),p2(2,1),p4(2,1),p3(2,1),p1(2,1)];

plot(x_vertices,y_vertices);
pause;
max_x=max(x_vertices);
min_x=min(x_vertices);
max_y=max(y_vertices);
min_y=min(y_vertices);


%Scan the area surrounding and including the polygon
for y=min_y:max_y
    for x=min_x:max_x
        %Only check the pixels actually within the polygon though
        if(inpolygon(x,y,x_vertices,y_vertices))
            %If the pixel is an edge pixel (is equal to 1), go in if
            %statement
            if(edge(x,y)==1)
                %Calculate the pixels distance from the midline of the box
                disp("highlighting...");
                disp(x);
                disp(y);
                I(x,y,1)=255;
                I(x,y,2)=0;
                I(x,y,3)=0;
                
            end
        end
    end 
end
imshow(I)
end

