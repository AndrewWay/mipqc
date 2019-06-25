function [ lines11,lines22 ] = trim_edges( lines11,lines22,I )
%TRIM_EDGES Summary of this function goes here
%   Detailed explanation goes here

rho_shift=15;
truth_threshold=0.7;
%Get center of MIP

[xInts,yInts]=find_intersections(lines11,lines22);


x_center = floor(mean(xInts(:)));
y_center = floor(mean(yInts(:)));
R = sqrt((x_center)^2+(y_center^2));

for i=1:2
    t=lines11(1,i);
    r=lines11(2,i);
    
    shifting_line=lines11(:,i);
    
    if(r<0)
        fprintf("rho is negative in trim_edges\n");
    end
    if(abs(r)<R)
        %Increment rho
        shift=rho_shift;
    else
        %Decrement rho
        shift=-rho_shift;
    end
    
    %Shift the line
    shifting_line(2,1)=shifting_line(2,1)+shift;
    

    lines=[shifting_line,lines22];
    I_lines=draw_all_lines(lines,'green',I);
    I_lines=draw_all_lines(shifting_line,'red',I_lines);
    %Calculate the truth of the segment
    [xInts,yInts]=find_intersections([[t;r],shifting_line],lines22);
    I_bw=im2bw(I);
    truth=calc_truth_of_region(xInts,yInts,I_bw);
    
    if(truth>truth_threshold)
        lines11(:,i)=shifting_line;
        trim_edges(lines11,lines22,I);
    else
        lines11(:,i)=[t;r];
    end
end

end

