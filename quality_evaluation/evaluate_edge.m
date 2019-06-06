function [rough_cells,weak_cells,n_cells,dl] = evaluate_edge( lines11,lines22,mip_edge)
%EVALUATE_EDGE Calculates roughness (average distance of edge pixels from
%hough line) and weakness (whether a cell has low edge pixels or not)
%returns coordinates of edge considered sufficiently rough, cells
%that are weak, and the TOTAL number of cells 
%returns width of cell

minimum_grade=0.7;

a=10;
dl=30;
min_edge_points=dl/2;

[xInts,yInts] = find_intersections(lines11,lines22);

line1=[xInts(1,1),yInts(1,1),xInts(1,2),yInts(1,2)];
line2=[xInts(1,1),yInts(1,1),xInts(2,1),yInts(2,1)];
line3=[xInts(2,1),yInts(2,1),xInts(2,2),yInts(2,2)];
line4=[xInts(2,2),yInts(2,2),xInts(1,2),yInts(1,2)];


all_lines=[line1;line2;line3;line4];

rough_cells=[];
weak_cells=[];
n_cells=0;
%Iterate through each of the four lines
for line_index=1:4
    
    current_line=all_lines(line_index,:);
    start_of_line=[current_line(1,1);current_line(1,2)];
    end_of_line=[current_line(1,3);current_line(1,4)];
    
    [end_points]=segment_line(start_of_line,end_of_line,dl);
    
    %Iterate through all segments of the current line
    for i=1:size(end_points,1)-1
        qi=end_points(i,:);
        qi=[qi(1,1);qi(1,2)];
        
        qip1=end_points(i+1,:);
        qip1=[qip1(1,1);qip1(1,2)];
        
        [roughness,p1,p2,p3,p4,n_edge_points]=calc_cell_roughness(qi,qip1,mip_edge,a);
        
        
        roughness_grade=1-(roughness)/a;
        cell_center=(p1+p2+p3+p4)/4;
        if(roughness_grade<minimum_grade)
            %Rescale roughness_grade 
            rough_cells=[rough_cells,cell_center];
        end
        if(n_edge_points<min_edge_points)
            weak_cells=[weak_cells,cell_center];
        end
       n_cells=n_cells+1; 
    end
    
end

end

