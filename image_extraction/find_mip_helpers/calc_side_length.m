function[s] = calc_side_length(line1,line2,line3)
[xints,yints]=find_intersections([line1],[line2 line3]);
    x1=xints(1,1);
    x2=xints(1,2);
    y1=yints(1,1);
    y2=yints(1,2);
    s=sqrt((x2-x1)^2+(y2-y1)^2);
end