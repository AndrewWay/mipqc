function [ rArray,end_points] = calc_roughness_array( q1,q2,edge )
%CALC_ROUGHNESS_ARRAY Calculates deviation of an edge from a line.
%Breaks the line up into segments, and calculates a deviation of the edge
%from each bin segment. 

%(x1,y1) is the first endpoint of the line. 
x1=q1(1,1);
y1=q1(2,1);
%(x2,y2) is the second endpoint of the line. 
x2=q2(1,1);
y2=q2(2,1);

line_length=sqrt((x2-x1)^2+(y2-y1)^2);

dl=30;
n=floor(line_length/dl);


dl=abs(line_length/n);


xi=x1;
yi=y1;

if(x2==x1)
    dx=0;
    dy=(y2-y1)/n;
else
    m=(y2-y1)/(x2-x1);
    theta=atan(m);
    dx=cos(theta)*dl;
    dy=sin(theta)*dl;
end

%(xi,yi) is the first end point of the bin. 
%(xip1,yip1) is the second end point of the bin (xi plus 1, yi plus 1).
rArray=zeros(n-1,1);
end_points=zeros(n,2);
for i=1:n-1
    qi=[xi;yi];
        
    xip1=xi+dx;
    yip1=yi+dy;
   
    
    qip1=[xip1;yip1];
 
    end_points(i,:)=[xi,yi];
    
    rArray(i,1)=calc_cell_roughness(qi,qip1,edge);
    
    %shift first endpoint to next endpoint.
    xi=xip1;
    yi=yip1;
end
end_points(n,:)=[xi,yi];
end

