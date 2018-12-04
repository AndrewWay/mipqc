function [ grade ] = grade_side_length( length,length_min,length_max )
%GRADE_SIDE_LENGTH Summary of this function goes here
%   length - the length of the line to be graded
%   length_min - the minimum allowable length
%   length_max - the maximum allowable length

length_mid=abs(length_max-length_min)/2;
grade_max = 0.25;

line11_1=lines11(:,1);
line11_2=lines11(:,2);
line22_1=lines22(:,1);
line22_2=lines22(:,2);


line1_length = calc_side_length(line11_1,line22_1,line_22);
line2_length = calc_side_length(line11_2,line22_1,line_22);

%GRADE_ANGLE Summary of this function goes here
%   Detailed explanation goes here
if(length<length_min || length>length_max)
    grade=-grade_max;
elseif(length>=length_min && angle<length_mid)
    grade=(grade_max/(length_mid-length_min))*(length-length_min);
elseif(length>length_mid&&angle<length_max)
    grade=((0-grade_max)/(length_max-length_mid))*(length-length_max);
else
    grade=grade_max;
end



end

