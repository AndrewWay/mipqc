function [ d ] = distance( p1,p2,q )
%Given two vertices and a point, returns orthogonal distance from that
%point to the line intersected by both vertices 

x0=q(1,1);
y0=q(2,1);

x1=p1(1,1);
y1=p1(2,1);

x2=p2(1,1);
y2=p2(2,1);


%ref: https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line
%Check under Cartesian Coordinates - Line defined by two points
d = abs((y2-y1)*x0-(x2-x1)*y0+x2*y1-y2*x1)/sqrt((y2-y1)^2+(x2-x1)^2);

end
