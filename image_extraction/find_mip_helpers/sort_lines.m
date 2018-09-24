function lines = sort_lines(lines)

t = lines(1,:); % Get all thetas
r = lines(2,:); % Get all rhos
% If most angles are between -45 .. +45 degrees, lines are mostly
% vertical.
nLines = size(lines,2);
nVertical = sum(abs(t)<=45);
if nVertical/nLines >= 0.5
% Mostly vertical lines. r=x*cos(t)+y*sin(t) 
% we need x assuming y =1 
dist = (-sind(t)*1 + r)./cosd(t); % horizontal distance
else
% Mostly horizontal lines. 
% we need y assuming x=1
dist = (-cosd(t)*1 + r)./sind(t); % vertical distance
end
[~,indices] = sort(dist, 'ascend');
lines = lines(:,indices);
end
