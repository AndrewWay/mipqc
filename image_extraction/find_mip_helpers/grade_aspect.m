
function[grade] = grade_aspect(si,sj,sk,sl)

peak_val=1.91;
peak_width=0.1;
if(sk>=si)
    aspect1=sk/si;
    aspect2=sk/sj;
    aspect3=sl/si;
    aspect4=sl/sj;    
else
    aspect1=si/sk;
    aspect2=si/sl;
    aspect3=sj/sk;
    aspect4=sj/sl;
end

aspect=(aspect1+aspect2+aspect3+aspect4)/4;

left=peak_val-peak_width;
center=peak_val;
right=peak_val+peak_width;

if(aspect<=left || aspect>=right)
    grade=0;
elseif(aspect>left && aspect<center)
    grade=(1/(1.85-1.6))*(aspect-1.6);
elseif(aspect>center&&aspect<right)
    grade=((-1)/(2-1.85))*(aspect-2);
else
    grade=1;
end


end
