function [ grade ] = grade_surface_area( area )
%GRADE_SURFACE_AREA Summary of this function goes here
%   Detailed explanation goes here
margin_of_error=18.5;%millimeter squared
best_area=188.5;%millimeter squared
min_area=best_area-margin_of_error;% millimeter squared
max_area=best_area+margin_of_error;%millimeter squared

max_score=1;
min_score=0;
punish_score=0;%-max_score;


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

