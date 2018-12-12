function [ rArray ] = calc_roughness_array( q1,q2,edge,th,alpha )
%CALC_ROUGHNESS_ARRAY Calculates deviation of an edge from a line.
%Breaks the line up into segments, and calculates a deviation of the edge
%from each bin segment. 

%(x1,y1) is the first endpoint of the line. 
x1=q1(1,1);
y1=q1(2,1);
%(x2,y2) is the second endpoint of the line. 
x2=q2(1,1);
y2=q2(2,1);

dx=alpha/2;

n=floor((x2-x1)/dx);

dx=abs((x2-x1)/n);


xi=x1;
yi=y1;

%TODO account for vertical line
m=(y2-y1)/(x2-x1);
b=y1-m*x1;
%(xi,yi) is the first end point of the bin. 
%(xip1,yip1) is the second end point of the bin (xi plus 1, yi plus 1).

for i=1:n-1
    qi=[xi;yi];
    [p1,p2]=calc_search_vertices(qi,th,alpha);
    
    xip1=xi+dx;
    yip1=m*xip1+b;
    
    
    qip1=[xip1;yip1];
    [p3,p4]=calc_search_vertices(qip1,th,alpha);

    
    
    
    %shift first endpoint to next endpoint.
    xi=xip1;
    yi=yip1;
end


rArray

end

