function [ end_points ] = segment_line(q1,q2,dl)
%SEGMENT_LINE Summary of this function goes here
%   Detailed explanation goes here
%(x1,y1) is the first endpoint of the line.
x1=q1(1,1);
y1=q1(2,1);

%(x2,y2) is the second endpoint of the line.
x2=q2(1,1);
y2=q2(2,1);

line_length=sqrt((x2-x1)^2+(y2-y1)^2);

n=floor(line_length/dl);

dl=line_length/n;

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


end_points=zeros(n,2);
for i=1:n
    end_points(i,:)=[xi,yi];
    xi=xi+dx;
    yi=yi+dy;
end

end

