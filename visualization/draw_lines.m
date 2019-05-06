
function [I] = draw_lines(lines11,lines22,I)
%DRAW Summary of this function goes here
%   Detailed explanation goes here

[xInts,yInts] = find_intersections(lines11,lines22);

lines=[xInts(1,1),yInts(1,1),xInts(1,2),yInts(1,2);
    xInts(1,1),yInts(1,1),xInts(2,1),yInts(2,1);
    xInts(2,1),yInts(2,1),xInts(2,2),yInts(2,2);
    xInts(2,2),yInts(2,2),xInts(1,2),yInts(1,2)];
        
% line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];
% line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];
% line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];
% line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];
% 
% imshow(I);
% 
% set(line(line1(1,:),line1(2,:),'linewidth',2,'color',[1,0,0]));
% set(line(line2(1,:),line2(2,:),'linewidth',2,'color',[0,1,0]));
% set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[0,0,1]));
% set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));

I=insertShape(I,'Line',lines,'LineWidth',6,'Color','green');

end

