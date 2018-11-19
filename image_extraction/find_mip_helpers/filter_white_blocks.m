function [ lines11,lines22 ] = filter_white_blocks( lines11,lines22,...
    lines1,lines2,I )
%FILTER_WHITE_BLOCKS Summary of this function goes here
%   Detailed explanation goes here

%lines11 contain 2 mostly parallel lines chosen for the sides of the
%rectangle. Similarly for lines22, except they are mostly orthogonal to
%the lines in lines11.

nLines1=size(lines1,2);
nLines2=size(lines2,2);

% tol=0.00001;
% %Remove lines11 from lines1
% for i=1:nLines1
%     t_i=lines1(1,i);
%     r_i=lines1(2,i);
%
%     if((abs(t_i-lines11(1,1))<tol...
%             &&abs(r_i-lines11(2,1))<tol)...
%             ||(abs(t_i-lines11(1,2))<tol...
%             &&abs(r_i-lines11(2,2))<tol))
%
%         lines1(:,i)=[];
%         i=i-1;
%         nLines1=nLines1-1;
%     end
% end

%Remove lines22 from lines2
% for i=1:nLines2
%     t_i=lines2(1,i);
%     r_i=lines2(2,i);
%
%     if((abs(t_i-lines22(1,1))<tol...
%             &&abs(r_i-lines22(2,1))<tol)...
%             ||(abs(t_i-lines22(1,2))<tol...
%             &&abs(r_i-lines22(2,2))<tol))
%
%         lines2(:,i)=[];
%     end
% end
% nLines1=size(lines1,2);
% nLines2=size(lines2,2);

%These variables indicate whether the (rho,theta) vectors are
%parallel or antiparallel.
if(lines11(1,1)*lines11(1,2)>=0)
    lines11_parallel=1;
end

if(lines22(1,1)*lines22(1,2)>=0)
    lines22_parallel=1;
end

imshow(draw_lines(lines11,lines22,I));
pause;
close all;

for i=1:nLines1
    line1_i=lines1(:,i);
    %Find the closest line from lines11
    t_i=line1_i(1,1);
    r_i=line1_i(2,1);
    
    %check if the current line is inside the rectangle
    if(lines11_parallel)
        %Check if current line rho < line11_1 rho and
        %rho > line11_2 rho
        if((r_i<lines11(2,1)&&r_i>lines11(2,2))...
                ||(r_i<lines11(2,2)&&r_i>lines11(2,1)))
            fprintf("%s\n",'Lines Parallel. New line is within rectangle.');
            %Find the line from lines11 that line1_i is closest to
            if(abs(r_i-lines11(2,1))<abs(r_i-lines11(2,2)))
                %Replace lines11(:,1) with line1_i
                lines11(:,2)=[t_i;r_i];
            else
                %Replace lines11(:,2) with line1_i
                lines11(:,2)=[t_i;r_i];
            end
            
            [leveled_I,leveled_lines11,leveled_lines22]=...
                level_mip(I,lines11,lines22);
            
            [xIntersections, yIntersections] = find_intersections(...
                leveled_lines11,...
                leveled_lines22);
            
            [px1,py1,px2,py2]=find_perfect_vertices(xIntersections,yIntersections);
            
            %Extract the leveled section
            extracted_mip = extract_rectangle(leveled_I,px1,py1,px2,py2);
            bw_mip_fragment = im2bw(extracted_mip);
            
            figure(1),imshow(draw_lines(leveled_lines11,...
                leveled_lines22,leveled_I));
            figure(2),imshow(extracted_mip);
            figure(3),imshow(bw_mip_fragment);
            fprintf("Truth: %d\n",truth(bw_mip_fragment));
            pause;
            close all;
            
        end
        
        
        
        %Form the rectangle from that closest line, and the two lines from
        %lines22
        
        %Calculate truth
        
        %If greater than threshold,
        
        %Replace the closest chosen line with line1_i
        
    end
end

end

