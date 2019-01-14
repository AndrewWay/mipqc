function [ area ] = calc_surface_area( lines11,lines22 )
%CALC_SURFACE_AREA Summary of this function goes here
%   Detailed explanation goes here
[xInts,yInts] = find_intersections(lines11,lines22);


line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];%1st vertical
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];%1st horizontal
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];%2nd vertical
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];%2nd horizontal



xv = [xInts(1,1);
      xInts(1,2);
      xInts(2,2);
      xInts(2,1);]
yv = [yInts(1,1);
      yInts(1,2);
      yInts(2,2);
      yInts(2,1);]

area = polyarea(xv,yv);
end

