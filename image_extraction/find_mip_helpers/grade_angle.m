function [ grade ] = grade_angle(angle)
%GRADE_ANGLE Summary of this function goes here
%   Detailed explanation goes here
if(angle<=85 || angle>=95)
    grade=0;
elseif(angle>85 && angle<90)
    grade=(0.25/(90-85))*(angle-85);
elseif(angle>90&&angle<95)
    grade=((0-0.25)/(95-90))*(angle-95);
else
    grade=0.25;
end

end

