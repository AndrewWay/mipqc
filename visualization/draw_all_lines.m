function [ I ] = draw_all_lines( lines,color,I )
%DRAW_ALL_LINES Draws lines specified by theta and rho in I 
n=size(lines,2);
I_size=size(I,2);
for i=1:n
   theta=lines(1,i);
   theta=theta*pi/180;
   rho=lines(2,i);
   y = hough_to_linear(theta,rho);
   x1=1;
   x2=I_size;
   y1=y(x1);
   y2=y(x2);
   line=[x1 y1 x2 y2];
   I=insertShape(I,'Line',line,'LineWidth',6,'Color',color);
end

end

