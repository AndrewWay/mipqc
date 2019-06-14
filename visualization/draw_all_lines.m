function [ I ] = draw_all_lines( lines,color,I )
%DRAW_ALL_LINES Summary of this function goes here
%   Detailed explanation goes here
n=size(lines,2);

for i=1:n
   theta=lines(1,i);
   rho=lines(2,i);
   
   I=insertShape(I,'Line',lines,'LineWidth',6,'Color','green');
end

end

