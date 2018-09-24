function [grade]=grade_angles(ti,tj,tk,tl,ang_tol)
grade=0;
%calculate angle between line i and line l
t_il=180-abs(ti-tl);
%calculate angle between line l and line j
t_lj=180-abs(tl-tj);
%calculate angle between line j and line k
t_jk=180-abs(tj-tk);
%calculate angle between line k and line i
t_ki=180-abs(tk-ti);
if(abs(t_il)-90<ang_tol)
    if(abs(t_lj)-90<ang_tol)
        if(abs(t_jk)-90<ang_tol)
            if(abs(t_ki)-90<ang_tol)
                grade=1;
            end
        end
    end
end
end
