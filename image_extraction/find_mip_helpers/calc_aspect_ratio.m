function [ rat ] = calc_aspect_ratio( length1,length2,length3,length4)
%CALC_ASPECT_RATIO Calculates aspect ratio of rectangle given 4 side
%lengths

%What sides are across from each other
% *-----1------*
% -            -
% 2            4
% -            -
% *-----3------*

ave_l1 = (length1+length3)/2;
ave_l2 = (length2+length4)/2;

rat=ave_l1/ave_l2;
if(rat<1)
   rat=1/rat; 
end

end

