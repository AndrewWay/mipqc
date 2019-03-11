function [ grade ] = grade_surface_area( area )
%GRADE_SURFACE_AREA Summary of this function goes here
%   Detailed explanation goes here
min_area=37000;
max_area=47000;
best_area=42000;
max_score=1;
min_score=0;
punish_score=-max_score;


if(area<=min_area || area>=max_area)
    grade=punish_score;
elseif(area>min_area && area<best_area)
     grade=((max_score-min_score)/(best_area-min_area))*(area-min_area);
 elseif(area>best_area&&area<max_area)
     grade=((min_score-max_score)/(max_area-best_area))*(area-max_area);
 else
     grade=max_score;
end

end

