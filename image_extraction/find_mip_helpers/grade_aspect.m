
function[grade] = grade_aspect(si,sj,sk,sl)
grade=0;
aspect_tol=0;
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
