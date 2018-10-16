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
    
    %TODO!!!! Figure out how to automatically set sign of rotAng
    rotAng=-1*rotAng;
end