function [tmp_fit_grade] = grade_rectangle(lines11,lines22,scale_factor)
%GRADE_RECTANGLE Summary of this function goes here
%   Detailed explanation goes here

linei=lines11(:,1);
linej=lines11(:,2);
linel=lines22(:,1);
linek=lines22(:,2);
ti=linei(1,1);
tj=linej(1,1);
tl=linel(1,1);
tk=linek(1,1);

[xints,yints]=find_intersections([linei,linej],[linel linek]);
[surface_area]=calc_surface_area(xints,yints);
surface_area=scale_factor*surface_area;
[si,sj,sk,sl]=calc_sides_lengths(linei,linej,linek,linel);
si=scale_factor*si;
sj=scale_factor*sj;
sk=scale_factor*sk;
sl=scale_factor*sl;
[area_grade]=grade_surface_area(surface_area);
[angle_grade]=grade_angles(ti,tj,tk,tl);
[aspect_grade]=grade_aspect(si,sj,sk,sl);

tmp_fit_grade=3*angle_grade+aspect_grade+2*area_grade;

end

