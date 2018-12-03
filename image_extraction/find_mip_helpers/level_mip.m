function [ mip,lines11,lines22] = level_mip(mip,lines11,lines22 )
%LEVEL_MIP Summary of this function goes here
%   Detailed explanation goes here

    %Rotate entire system to be level with axes
    [rotAng] = find_rotation_angle(lines11,lines22);
    %E=imrotate(E,-1*rotAng,'bilinear','crop');

    mip=rotate_around(mip,0,0,rotAng,'bilinear');
    
    for i=1:size(lines11,2)
       lines11(1,i)=lines11(1,i)-rotAng; 
    end
    for i=1:size(lines22,2)
       lines22(1,i)=lines22(1,i)-rotAng; 
    end
end

