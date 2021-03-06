%Rescale the image if necessary. High resolution is not necessary and
%increases computation time.
clear all
close all


min_grade=0.7;
max_grade=1-min_grade;

I0 = imread('data/B/MIP7.jpg');
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
%lines11: mostly vertical
%lines22: mostly horizontal

[xInts,yInts] = find_intersections(lines11,lines22);


line1=[xInts(1,1),xInts(1,2);yInts(1,1),yInts(1,2)];%1st vertical
line2=[xInts(1,1),xInts(2,1);yInts(1,1),yInts(2,1)];%1st horizontal
line3=[xInts(2,1),xInts(2,2);yInts(2,1),yInts(2,2)];%2nd vertical
line4=[xInts(2,2),xInts(1,2);yInts(2,2),yInts(1,2)];%2nd horizontal



%mip_edge = extract_mip_edge(lines11,lines22,mip_edge);

mip_edge_coords=calc_edge_positions(mip_edge);
edge_size=size(mip_edge_coords,1);

for i=1:size(mip_edge_coords,1)
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    
    I0(y,x,1)=uint8(255);
    I0(y,x,2)=uint8(0);
    I0(y,x,3)=uint8(255);
    
end

%err=calc_hough_line_err(mip_edge_coords,line1,line2,line3,line4);
sides=zeros(2,2,4);
angles=zeros(1,4);
sides(:,:,1)=line1;
sides(:,:,2)=line2;
sides(:,:,3)=line3;
sides(:,:,4)=line4;
angles(1)=lines11(1,1);
angles(2)=lines22(1,1);
angles(3)=lines11(1,2);
angles(4)=lines22(1,2);
imshow(I0);
hold on;

for side=1:4
    l=sides(:,:,side);
    q1=l(:,1);
    q2=l(:,2);
    a=10;%half height of search area (height above the line)
    th=angles(side);
    th=th*pi/180;
    
    
    
    %(x1,y1) is the first endpoint of the line.
    x1=q1(1,1);
    y1=q1(2,1);
    %(x2,y2) is the second endpoint of the line.
    x2=q2(1,1);
    y2=q2(2,1);
%     
%     if(y1>y2)
%         tmpx=x2;
%         tmpy=y2;
%         x2=x1;
%         y2=y1;
%         x1=tmpx;
%         y1=tmpy;
%     end
%     
    ds=a/2;
    
    line_length=sqrt((x2-x1)^2+(y2-y1)^2);
    n=floor(line_length/ds);
    
    dx=abs(ds*sin(th));
    dy=abs(ds*cos(th));

    if(x2<x1)
       dx=-1*dx; 
    end
    
    if(y2<y1)
       dy=-1*dy; 
    end
    
    xi=x1;
    yi=y1;
    
    xip1=xi+dx;
    yip1=yi+dy;
    
    %(xi,yi) is the first end point of the bin.
    %(xip1,yip1) is the second end point of the bin (xi plus 1, yi plus 1).
    
    set(line(l(1,:),l(2,:),'linewidth',2,'color',[1,0,0]));
    %set(line(line2(1,:),line2(2,:),'linewidth',1,'color',[1,0,0]));
    %set(line(line3(1,:),line3(2,:),'linewidth',2,'color',[1,0,0]));
    % set(line(line4(1,:),line4(2,:),'linewidth',2,'color',[1,1,0]));
    
    max_bin_err=a;
    
    keep_running=1;
    s=0;
    while(s<=line_length)
        qi=[xi;yi];
        [p1,p2]=calc_search_vertices(qi,th,a);
        
        
        qip1=[xip1;yip1];
        [p3,p4]=calc_search_vertices(qip1,th,a);
        
        bin_err=0;
        n_points_in_bin=0;
        
        for j=1:size(mip_edge_coords,1)
            x=mip_edge_coords(j,1);
            y=mip_edge_coords(j,2);
            
            if(point_is_in_box(x,y,p1,p2,p3,p4))
                n_points_in_bin=n_points_in_bin+1;
                %fprintf("(%d,%d) in box\n",x,y);
                set(line([x-1,x],[y-1,y],'linewidth',2,'color',[0,0,1]));
                %Calculate its orthogonal distance from the current point to each line
                point_distance = distance(q1,q2,[x;y]);
                bin_err=bin_err+point_distance;
            end
        end
        
        %Average the distances
        if(n_points_in_bin==0)
            bin_grade=0;
        else
            bin_err=bin_err/n_points_in_bin;
            bin_grade=1-bin_err/max_bin_err;
            bin_grade=(bin_grade-min_grade)/max_grade;
            if(bin_grade<0)
                bin_grade=0;
            end
        end
        box_color=gradeColor(bin_grade);
        
        set(line([p1(1,1),p2(1,1)],[p1(2,1),p2(2,1)],'linewidth',1,'color',box_color));
        set(line([p1(1,1),p3(1,1)],[p1(2,1),p3(2,1)],'linewidth',1,'color',box_color));
        set(line([p3(1,1),p4(1,1)],[p3(2,1),p4(2,1)],'linewidth',1,'color',box_color));
        set(line([p4(1,1),p2(1,1)],[p4(2,1),p2(2,1)],'linewidth',1,'color',box_color));
        
        xi=xip1;
        yi=yip1;
        xip1=xi+dx;
        yip1=yi+dy;
        s=sqrt((xip1-x1)^2+(yip1-y1)^2);
    end
end
hold off;
% fprintf("Error: %d\n",err);




