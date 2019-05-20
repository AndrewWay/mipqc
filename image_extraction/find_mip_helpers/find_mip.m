function [lines11,lines22,success] = find_mip(I)
%FIND_MIP Finds the region of an image that contains a MIP
fprintf('%s\n','Running MIP extraction routine...');


[lines1,lines2]=find_vertical_and_horizontal_lines(I);

if(isempty(lines1)||isempty(lines2))
    success=0;
    lines11=0;
    lines22=0;
else
    
    %     % Show the two sets of lines.
    %     figure(12), imshow(E), title('Orthogonal lines');
    %     draw_lines( lines1(2,:), ... % rhos for the lines
    %         lines1(1,:), ... % thetas for the lines
    %         size(E), ... % size of image being displayed
    %         'g'); % color of line to display
    %
    %
    %     draw_lines( lines2(2,:), ... % rhos for the lines
    %         lines2(1,:), ... % thetas for the lines
    %         size(E), ... % size of image being displayed
    %         'r'); % color of line to display
    %
    %     pause;
    %     close all;
    %find the set of lines that form the best rectangle
    

    [lines11,lines22] = find_rectangle(lines1,lines2,I);
    %     fprintf("%s\n","line 80, find_mip");
    %     figure(1), imshow(draw_lines(lines11,lines22,I));
    %     pause;
    %     close(figure(1));
    if(isempty(lines11)||isempty(lines22))
        fprintf("ERROR: find_mip failed to find the MIP.\n");
        success=0;
    else
        success=1;
        [lines11,lines22] = filter_white_blocks(lines11,lines22,lines1,lines2,I);
        
        %find the outer pair of lines
        %lines11=[lines1(:,1) lines1(:,end)];
        %lines22=[lines2(:,1) lines2(:,end)];
        
        
        
        %figure(10), imshow(E), title('Edges');
        %
        %     nXcoords = size(xIntersections,1)*size(xIntersections,2);
        %     nYcoords = size(yIntersections,1)*size(yIntersections,2);
        %
        %     xv = zeros(nXcoords,1);
        %     yv = zeros(nYcoords,1);
        %
        %     tmpIndex=1;
        %     for i=1:size(xIntersections,1)
        %         for j=1:size(xIntersections,2)
        %             xv(tmpIndex,1) = xIntersections(i,j);
        %             tmpIndex=tmpIndex+1;
        %         end
        %     end
        %
        %     tmpIndex=1;
        %     for i=1:size(yIntersections,1)
        %         for j=1:size(yIntersections,2)
        %             yv(tmpIndex,1) = yIntersections(i,j);
        %             tmpIndex=tmpIndex+1;
        %         end
        %     end
        %
        %     xq=linspace(1,size(I,2),1);
        %     yq=linspace(1,size(I,1),1);
        %
        % Plot outer lines and intersection points.
        %     figure(1),
        %     hold on
        %     drawLines( lines11(2,:), ... % rhos for the lines
        %         lines11(1,:), ... % thetas for the lines
        %         size(E), ... % size of image being displayed
        %         'g'); % color of line to display
        %
        %     drawLines( lines22(2,:), ... % rhos for the lines
        %         lines22(1,:), ... % thetas for the lines
        %         size(E), ... % size of image being displayed
        %         'r'); % color of line to display
        %
        %     plot(xIntersections(:),yIntersections(:),'s', 'MarkerSize',10, 'MarkerFaceColor','r');
        %     hold off
    end
end
end

function drawLines(rhos, thetas, imageSize, color)
% This function draws lines on whatever image is being displayed.
% Input parameters:
% rhos,thetas: representation of the line (theta in degrees)
% imageSize: [height,width] of image being displayed
% color: color of line to draw
% Equation of the line is rho = x cos(theta) + y sin(theta), or
% y = (rho - x*cos(theta))/sin(theta)

for i=1:length(thetas)
    %if majority of angles are >45 then line is is mostly horizontal.
    %Pick two values of x, and solve for y = (-ax-c)/b
    %else the line is is mostly horizontal. Pick two values of y,
    % and solve for x
    
    %students write your code here
    theta=thetas(i)*pi/180;
    rho=rhos(i);
    a=cos(theta);
    c=-rho;
    b=sin(theta);
    if(theta>45)
        x0=1;
        x1=imageSize(2);
        y0=(-a*x0-c)/b;
        y1=(-a*x1-c)/b;
    else
        y0=1;
        y1=imageSize(2);
        x0=(b*y0+c)/(-a);
        x1=(b*y1+c)/(-a);
    end
    
    line([x0 x1], [y0 y1], 'Color', color);
    text(x0,y0,sprintf('%d', i), 'Color', color);
end
end

