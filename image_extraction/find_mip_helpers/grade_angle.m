function [ grade ] = grade_angle(angle)
%GRADE_ANGLE Summary of this function goes here
%   Detailed explanation goes here
min_angle=88;
max_angle=92;
best_angle=90;
max_score=0.25;
min_score=0;

if(angle<=min_angle || angle>=max_angle)
    grade=min_score;
elseif(angle>min_angle && angle<best_angle)
    grade=((max_score-min_score)/(best_angle-min_angle))*(angle-min_angle);
elseif(angle>best_angle&&angle<max_angle)
    grade=((min_score-max_score)/(max_angle-best_angle))*(angle-max_angle);
else
    grade=max_score;
end

end

