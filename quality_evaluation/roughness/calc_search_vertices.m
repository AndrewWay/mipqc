function [ p1,p2 ] = calc_search_vertices( qi,th,a )
%CALC_SEARCH_VERTICES Calculates the endpoints of a line centered 
%at qi, with length 2*alpha, with angle th relative to the x axis

xi=qi(1,1);
yi=qi(2,1);
x_shift=a*cos(th);
y_shift=a*sin(th);

p1=[xi-x_shift;yi-y_shift];
p2=[xi+x_shift;yi+y_shift];

p1=round(p1);
p2=round(p2);

end

