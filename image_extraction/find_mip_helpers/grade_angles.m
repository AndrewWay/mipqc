function [grade]=grade_angles(ti,tj,tk,tl)

%calculate angle between line i and line l
t_il=180-abs(ti-tl);
%calculate angle between line l and line j
t_lj=180-abs(tl-tj);
%calculate angle between line j and line k
t_jk=180-abs(tj-tk);
%calculate angle between line k and line i
t_ki=180-abs(tk-ti);

t_il_score=grade_angle(t_il);
t_lj_score=grade_angle(t_lj);
t_jk_score=grade_angle(t_jk);
t_ki_score=grade_angle(t_ki);
%fprintf("grade_angles: Internal Angles: %f %f %f %f\n",t_il,t_lj,t_jk,t_ki);


grade=t_il_score+t_lj_score+t_jk_score+t_ki_score;
end
