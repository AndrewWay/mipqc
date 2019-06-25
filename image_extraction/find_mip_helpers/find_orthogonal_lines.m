function [lines1, lines2] = find_orthogonal_lines( ...
rhoValues, ... % rhos for the lines
thetaValues) % thetas for the lines

%lines1: mostly vertical
%lines2: mostly horizontal

% Find the largest two modes in the distribution of angles.
%create a set of angles in an array called bins from -90 to 90 with step 10
%then use histcounts to get the histogram
%sort and the first angle corresponds to the largest histogram count.
% The 2nd angle corresponds to the next largest count.
% 
% ang_i=-90;
% ang_f=90;
% ang_step=10;
% ang_n = 19;
% bins = zeros(1,ang_n);
% for i=1:ang_n
%    bins(i) = (i-1)*ang_step+ang_i; 
% end
% 
% [counts,bins] = histcounts(thetaValues,bins);
% 
% [~,indices] = sort(counts);
% 
% nIndices = size(indices,2);
% 
% %Find most common angle for horizontal lines
% hAngle_index=0;
% for i=nIndices:-1:1
%     tmp_angle=bins(indices(i));
%     if(abs(tmp_angle)>45)
%        %the line is mostly horizontal
%        hAngle_index=tmp_angle;
%        i=nIndices+1;
%     end
% end
% 
% %Find most common angle for vertical lines
% vAngle_index=0;
% for i=nIndices:-1:1
%     tmp_angle=bins(indices(i));
%     if(abs(tmp_angle)<=45)
%        %the line is mostly horizontal
%        vAngle_index=tmp_angle;
%        i=nIndices+1;
%     end
% end
% 
% a1=vAngle_index;
% a2=hAngle_index;

%fprintf('Most common verticle angle: %f \n', a1);
%fprintf('Most common horizontal angle: %f \n', a2);

% Get the two sets of lines corresponding to the two angles. Lines will
% be a 2xN array, where

lines1 = [];
lines2 = [];
for i=1:length(rhoValues)
% Extract rho, theta for this line
r = rhoValues(i);
t = thetaValues(i);
% Check if the line is close to one of the two angles.
%D = 25; % threshold difference in angle
if abs(t)<45
%if abs(t-a1) < D || abs(t-180-a1) < D || abs(t+180-a1) < D
    lines1 = [lines1 [t;r]];
%elseif abs(t-a2) < D || abs(t-180-a2) < D || abs(t+180-a2) < D
else
    lines2 = [lines2 [t;r]];
end
end
end