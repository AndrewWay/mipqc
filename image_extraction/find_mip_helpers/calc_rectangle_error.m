
function [fiterr]=calc_rectangle_error(ti,tj,tk,tl)
%TODO Calculate angles of intersections of sides in other function

%calculate angle between line i and line l
t_il=180-abs(ti-tl);
%calculate angle between line l and line j
t_lj=180-abs(tl-tj);
%calculate angle between line j and line k
t_jk=180-abs(tj-tk);
%calculate angle between line k and line i
t_ki=180-abs(tk-ti);

%calculate err
fiterr=0;
%ti and tj should be parallel
fiterr=fiterr + (ti-tj)^2;
%tk and tl should be parallel
fiterr=fiterr + (tk-tl)^2;

%ti and tk should be orthogonal
fiterr=fiterr + (t_ki-90)^2;
%ti and tl should be orthogonal
fiterr=fiterr + (t_il-90)^2;
%tj and tk should be orthogonal
fiterr=fiterr + (t_jk-90)^2;
%tj and tl should be orthogonal
fiterr=fiterr + (t_lj-90)^2;
end