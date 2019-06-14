clear all
close all


minimum_grade=0.7;
maximum_grade=1-minimum_grade;
a=10;
dl=30;
min_edge_points=dl/2;

I = imread('data/D_raw/_MG_6884.png');


%ORIGINAL IMAGE
figure(1),imshow(I);
pause;

%Find the four lines
[lines1,lines2] = find_vertical_and_horizontal_lines(I);

[candidate_rectangles] = find_candidate_rectangles(lines1,lines2);

%IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
candidate_rectangles=sortrows(candidate_rectangles,5);

best_rectangle = candidate_rectangles(end,1:4);
lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
%lines11: mostly vertical
%lines22: mostly horizontal

[xInts,yInts] = find_intersections(lines11,lines22);

%Calculate coordinates of mip edge
gray_I=rgb2gray(I);
otsu_thresh=graythresh(gray_I);
mip_edge = edge(gray_I,'canny',otsu_thresh);

mip_edge_coords=calc_edge_positions(mip_edge);
edge_size=size(mip_edge_coords,1);

line1=[xInts(1,1),yInts(1,1),xInts(1,2),yInts(1,2)];
line2=[xInts(1,1),yInts(1,1),xInts(2,1),yInts(2,1)];
line3=[xInts(2,1),yInts(2,1),xInts(2,2),yInts(2,2)];
line4=[xInts(2,2),yInts(2,2),xInts(1,2),yInts(1,2)];

I=draw_lines(lines11,lines22,I);

all_lines=[line1;line2;line3;line4];

%Add mip edge to image
for i=1:size(mip_edge_coords,1)
    x=mip_edge_coords(i,1);
    y=mip_edge_coords(i,2);
    
    I(y,x,1)=uint8(255);
    I(y,x,2)=uint8(0);
    I(y,x,3)=uint8(255);
    
end

for line_index=1:4
    
    current_line=all_lines(line_index,:);
    start_of_line=[current_line(1,1);current_line(1,2)];
    end_of_line=[current_line(1,3);current_line(1,4)];
    
    [end_points]=segment_line(start_of_line,end_of_line,dl);
    
    for i=1:size(end_points,1)
        
        qi=end_points(i,:);
        qi=[qi(1,1);qi(1,2)];
        
        if(i==size(end_points,1))
            qip1=[end_of_line(1,1);end_of_line(2,1)];
        else
            qip1=end_points(i+1,:);
            qip1=[qip1(1,1);qip1(1,2)];
        end
        [roughness,p1,p2,p3,p4,n_edge_points]=calc_cell_roughness(qi,qip1,mip_edge,a);
        
        
        roughness_grade=1-(roughness)/a;
        
        if(roughness_grade<0)
            fprintf("WARNING: Roughness grade in test_calc_roughness_array.m is negative. Check this.\n");
            roughness_grade=0;
        end
        
        if(roughness_grade<minimum_grade)
            %Rescale roughness_grade 
            roughness_grade=(roughness_grade-minimum_grade)/maximum_grade;
            if(roughness_grade<0)
               roughness_grade=0; 
            end
            box_color=gradeColor(roughness_grade);
            %I=insertShape(I,'Line',[qi(1,1),qi(2,1),qip1(1,1),qip1(2,1)],'Color','red');
            I=insertShape(I,'Line',[p1(1,1),p1(2,1),p2(1,1),p2(2,1)],'Color',box_color);
            I=insertShape(I,'Line',[p2(1,1),p2(2,1),p4(1,1),p4(2,1)],'Color',box_color);
            I=insertShape(I,'Line',[p4(1,1),p4(2,1),p3(1,1),p3(2,1)],'Color',box_color);
            I=insertShape(I,'Line',[p3(1,1),p3(2,1),p1(1,1),p1(2,1)],'Color',box_color);
        end
        if(n_edge_points<min_edge_points)
            circle_center=(p1+p2+p3+p4)/4;
            I=insertShape(I,'circle',[circle_center(1,1) circle_center(2,1) dl/2],...
                'LineWidth',3,'Color','Cyan');
        end
        
    end
    
end



imshow(I);