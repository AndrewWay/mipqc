function [x1,y1,x2,y2] = find_perfect_vertices(xints,yints)
%Find a perfect rectangular region of maximum surface area within a region
    %a - upper left
    %b - upper right
    %c - lower right
    %d - lower left
    
    xints=[xints(:,1);xints(:,2)];
    yints=[yints(:,1);yints(:,2)];
    [xints, x_order] = sort(xints);
    %yints = yints(x_order);
    [yints, y_order] = sort(yints);
    
    x1=xints(2,1);
    x2=xints(3,1);
    y1=yints(2,1);
    y2=yints(3,1);
    

end

