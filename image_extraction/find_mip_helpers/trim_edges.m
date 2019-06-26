function [ lines11,lines22 ] = trim_edges( lines11,lines22,I )
%TRIM_EDGES Summary of this function goes here
%   Detailed explanation goes here

rho_shift=3;
truth_threshold=0.5;
%Get center of MIP

[xInts,yInts]=find_intersections(lines11,lines22);


x_center = floor(mean(xInts(:)));
y_center = floor(mean(yInts(:)));
R = sqrt((x_center)^2+(y_center^2));

for i=1:2
    t=lines11(1,i);
    r=lines11(2,i);
    
    shifting_line=lines11(:,i);
    theta=t*pi/180;
    
    rad = sqrt((cos(theta)*r)^2+(sin(theta)*r)^2);
    
    
    shift=0;
    if(rad<x_center)
        %Increment rho
        shift=rho_shift;
    else
        %Decrement rho
        shift=-rho_shift;
    end
    
    if(r<0&&t<0)
        shift=-shift;
    end
    
    %Shift the line
    shifting_line(2,1)=shifting_line(2,1)+shift;
    
    
    lines=[shifting_line,lines22];
    I_lines=draw_all_lines(lines,'green',I);
    I_lines=draw_all_lines(shifting_line,'red',I_lines);
    %Calculate the truth of the segment
    [xInts,yInts]=find_intersections([[t;r],shifting_line],lines22);
    
    I_bw=im2bw(I,graythresh(I));
    truth=calc_truth_of_region(xInts,yInts,I_bw);
    
    %Recursively trim the lines until it hits a dark region
    if(truth>truth_threshold)
        lines11(:,i)=shifting_line;
        [lines11,lines22]=trim_edges(lines11,lines22,I);
    else
        lines11(:,i)=[t;r];
    end
end


for i=1:2
    t=lines22(1,i);
    r=lines22(2,i);
    
    shifting_line=lines22(:,i);
    theta=t*pi/180;
    rad = sqrt((cos(theta)*r)^2+(sin(theta)*r)^2);
    
    shift=0;
    if(rad<y_center)
        %Increment rho
        shift=rho_shift;
    else
        %Decrement rho
        shift=-rho_shift;
    end
    
    if(r<0&&t<0)
        shift=-shift;
    end
    
    %Shift the line
    shifting_line(2,1)=shifting_line(2,1)+shift;
    
    
    
    I_lines=draw_all_lines([lines11,[t;r]],'green',I);
    I_lines=draw_all_lines(shifting_line,'red',I_lines);
    %Calculate the truth of the segment
    [xInts,yInts]=find_intersections(lines11,[[t;r],shifting_line]);
    
    I_bw=im2bw(I,graythresh(I));
    truth=calc_truth_of_region(xInts,yInts,I_bw);
    
    %Recursively trim the lines until it hits a dark region
    if(truth>truth_threshold)
        lines22(:,i)=shifting_line;
        [lines11,lines22]=trim_edges(lines11,lines22,I);
    else
        lines22(:,i)=[t;r];
    end
end

end

