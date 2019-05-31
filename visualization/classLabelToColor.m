function [color] = classLabelToColor(classLabel)
%CLASSLABELTOCOLOR Summary of this function goes here
%   Detailed explanation goes here
if(classLabel == 1)
    color = [255,0,0];
elseif(classLabel == 2)
    color=[0,0,255];
elseif(classLabel ==3)
    color=[0,255,0];
elseif(classLabel==4)
    color=[0,255,255];
else
    color=[0,0,0];
end

end

