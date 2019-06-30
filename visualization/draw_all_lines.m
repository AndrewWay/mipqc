function [ I ] = draw_all_lines( lines,color,I )
%DRAW_ALL_LINES Draws lines specified by theta and rho in I
n=size(lines,2);
I_size=size(I,2);
line_width=6;

for i=1:n
    theta=lines(1,i);
    theta=theta*pi/180;
    
    rho=lines(2,i);
    y = hough_to_linear(theta,rho);
    x1=1;
    x2=I_size;
    
    if(mod(theta,pi)==0)
        y1=1;
        y2=size(I,1);
        x1=rho;
        x2=rho;
    else
        
        y1=y(x1);
        y2=y(x2);
    end
    
    line=[x1 y1 x2 y2];
    I=insertShape(I,'Line',line,'LineWidth',line_width,'Color',color);
end

end

