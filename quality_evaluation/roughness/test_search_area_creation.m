%Rescale the image if necessary. High resolution is not necessary and 
%increases computation time. 
clear all
close all


I0 = imread('data/B/MIP2.jpg');
if size(I0,2)>640
    I0 = imresize(I0, 640/size(I0,2));
    scale_factor=size(I0,2)/640;
    rescale=1;
else
    I0=I0;
    rescale=0;
end
%Retrieve the sets of lines enclosing the MIP in image I
[lines11,lines22,mip_edge] = find_mip(I0);

[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];%Vertical line 1
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];%Horizontal Line 1
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];%Vertical line 2
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];%Horizontal Line 2



mip_edge = extract_mip_edge(lines11,lines22,mip_edge);

mip_edge_coords=calc_edge_positions(mip_edge);


for i=1:size(mip_edge_coords,1)
   x=mip_edge_coords(i,1);
   y=mip_edge_coords(i,2);
   
   I0(y,x,1)=uint8(255);
   I0(y,x,2)=uint8(0);
   I0(y,x,3)=uint8(255);
   
end

%err=calc_hough_line_err(mip_edge_coords,line1,line2,line3,line4);

imshow(I0);

%set(line(line1(1,:),line1(2,:),'linewidth',2,'color',[1,0,0]));
set(line(line2(1,:),line2(2,:),'linewidth',2,'color',[1,0,0]));
%set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[0,0,1]));
% set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));

q1=line2(:,1);
q2=line2(:,2);
a=20;
th=lines22(1,1);

%(x1,y1) is the first endpoint of the line. 
x1=q1(1,1);
y1=q1(2,1);
%(x2,y2) is the second endpoint of the line. 
x2=q2(1,1);
y2=q2(2,1);

dx=a/2;

n=floor((x2-x1)/dx);

dx=abs((x2-x1)/n);


xi=x1;
yi=y1;

%TODO account for vertical line
m=(y2-y1)/(x2-x1);
b=y1-m*x1;
%(xi,yi) is the first end point of the bin. 
%(xip1,yip1) is the second end point of the bin (xi plus 1, yi plus 1).

for i=1:n
    qi=[xi;yi];
    [p1,p2]=calc_search_vertices(qi,th,a);
    
    xip1=xi+dx;
    yip1=m*xip1+b;
    
    
    qip1=[xip1;yip1];
    [p3,p4]=calc_search_vertices(qip1,th,a);

   set(line([p1(1,1),p2(1,1)],[p1(2,1),p2(2,1)],'linewidth',2,'color',[0,1,0]));
    set(line([p1(1,1),p3(1,1)],[p1(2,1),p3(2,1)],'linewidth',2,'color',[0,1,0]));
    set(line([p3(1,1),p4(1,1)],[p3(2,1),p4(2,1)],'linewidth',2,'color',[0,1,0]));
   set(line([p4(1,1),p2(1,1)],[p4(2,1),p2(2,1)],'linewidth',2,'color',[0,1,0]));
    
    
    %shift first endpoint to next endpoint.
    xi=xip1;
    yi=yip1;
end





hold off;
% fprintf("Error: %d\n",err);




