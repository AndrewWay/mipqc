function [x1,x2,y1,y2] = sectionCorners(i,j,dim1Inc,dim2Inc)
    y1=(i-1)*dim1Inc+1;
    x1=(j-1)*dim2Inc+1;
    y2=y1+dim1Inc;
    x2=x1+dim2Inc;
      
end