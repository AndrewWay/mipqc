function [ bool ] = formsRectangle(lines11,lines22)
%Indicates whether the lines described by lines11 and lines22 forms a
%rectangle
    ti=lines11(1,1);
    tj=lines11(1,2);
    tk=lines22(1,1);
    tl=lines22(1,2);
    grade = grade_angles(ti,tj,tk,tl);
    if(grade>=0.8)
        bool=1;
    else
        bool=0;
    end
end

