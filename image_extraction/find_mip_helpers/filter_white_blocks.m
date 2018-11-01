function [ lines11,lines22 ] = filter_white_blocks( lines11,lines22,...
    lines1,lines2,I )
%FILTER_WHITE_BLOCKS Summary of this function goes here
%   Detailed explanation goes here

%lines11 contain 2 mostly parallel lines chosen for the sides of the
%rectangle. Similarly for lines22, except they are mostly orthogonal to
%the lines in lines11. 

nLines1=size(lines1,2);
nLines2=size(lines2,2);

%Remove lines11 from lines1
lines1=setxor(lines1,lines11);
%Remove lines22 from lines2
lines2=setxor(lines2,lines22);

nLines1=size(lines1,2);
nLines2=size(lines2,2);

for i=1:nLines1
   line1_i=lines1(:,i);
   %Find the closest line from lines11
   t_i=line1_i(1,1);
   r_i=line1_i(2,1);

   %Find the line from lines11 that line1_i is closest to
   
   %Form the rectangle from that closest line, and the two lines from
   %lines22
   
   %Calculate truth
   
   %If greater than threshold, 
   
     %Replace the closest chosen line with line1_i
            
   end
   
   
end

end

