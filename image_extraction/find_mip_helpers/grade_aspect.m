
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


aspect=(aspect1+aspect2+aspect3+aspect4)/4;
if(aspect>=1.6)
    if(aspect<=1.91)
        grade=1;
    end
end

end
