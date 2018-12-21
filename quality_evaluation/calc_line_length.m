function [ length ] = calc_line_length( line,cal_factor )
%CALC_LINE_LENGTH returns length of line
    %line is in format of [x1,x2;y1,y2]
    x1=line(1,1);
    x2=line(1,2);
    y1=line(2,1);
    y2=line(2,2);
    
    length=sqrt((x2-x1)^2+(y2-y1)^2);

    if exist('cal_factor','var')
       length=cal_factor*length;
    end
end

