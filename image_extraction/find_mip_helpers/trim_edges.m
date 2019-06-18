function [ lines11,lines22 ] = trim_edges( lines11,lines22,I )
%TRIM_EDGES Summary of this function goes here
%   Detailed explanation goes here

%Get center of MIP

[xInts,yInts]=find_intersections(lines11,lines22);


x_center = floor(mean(xInts));
y_center = floor(mean(yInts));

for i=1:4
    if(i<3)
        rho=lines11(
        x_shift=0;
        y_shift=0;
    else
        
    end
    
    while
   %check whether to shift positive or negative
   
    
    end
end

end

