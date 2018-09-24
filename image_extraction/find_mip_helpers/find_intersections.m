function [xIntersections, yIntersections] = find_intersections(lines1, lines2)
%Finds the x and y coordinates of intersections between two sets of lines

    % Intersect pairs of lines, one from set 1 and one from set 2.
    % Output arrays contain the x,y coordinates of the intersections of lines.
    % xIntersections(i1,i2): x coord of intersection of i1 and i2
    % yIntersections(i1,i2): y coord of intersection of i1 and i2

    N1 = size(lines1,2);
    N2 = size(lines2,2);
    xIntersections = zeros(N1,N2);
    yIntersections = zeros(N1,N2);
 
    %see�Szeliski book�section�2.1.1
    % A line is represented in homogenous coordiante system by (a,b,c), 
    % where ax+by+c=0.
    % We have r = x cos(t) + y sin(t), or x cos(t) + y sin(t) - r = 0
    % Two lines l1 and l2 intersect at a point p where p = l1 cross l2
    
    for i1=1:N1
        
        %students write your code here
        r1 = lines1(2,i1);
        t1 = lines1(1,i1);
        t1 = t1*pi/180;
        l1 = [cos(t1) sin(t1) -r1];
        
        for i2=1:N2
            
            %students write your code here
            r2 = lines2(2,i2);
            t2 = lines2(1,i2);
            t2 = t2*pi/180;
            l2 = [cos(t2) sin(t2) -r2];
        
            p=cross(l1,l2);
            
            %bring point back from homogenous coord to the 2D coord
            p = p/p(3);
            xIntersections(i1,i2) = p(1);
            yIntersections(i1,i2) = p(2);
        end
    end
end