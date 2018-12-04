function [rotAng] = find_rotation_angle(lines1,lines2)
    
    ang_cumul=0;
    for i=1:size(lines1,2)
        t=mod(lines1(1,i),90);
        if(t>=45)
           t=90-t; 
        end
        ang_cumul=ang_cumul+t; 
    end
    for i=1:size(lines2,2)
        t=mod(lines2(1,i),90);
        if(t>=45)
           t=90-t; 
        end
        ang_cumul=ang_cumul+t;
    end
    rotAng=ang_cumul/(size(lines1,2)+size(lines2,2));
    if(rotAng>=45)
        rotAng=90-aveAng;
    end
    
    %TODO Maybe find better way of setting CCW vs CW rotation?
    if(lines1(1,1)<0&&lines1(1,2)<0)
        rotAng=-1*rotAng;    
    else if(lines1(1,1)*lines1(1,2)<0)
        fprintf("Potential error in find_rotation_angle\n");
    end
end