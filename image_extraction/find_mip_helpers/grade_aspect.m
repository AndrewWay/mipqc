
function[grade] = grade_aspect(si,sj,sk,sl)

grade_max=1;
aspect_mid=1.7;
aspect_dev=0.2;
aspect_min=aspect_mid-aspect_dev;
aspect_max=aspect_mid+aspect_dev;

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

if(aspect<aspect_min || aspect>aspect_max)
    grade=0;
elseif(aspect>=aspect_min && aspect<aspect_mid)
    grade=(grade_max/(aspect_mid-aspect_min))*(aspect-aspect_min);
elseif(aspect>aspect_mid&&aspect<=aspect_max)
    grade=((0-grade_max)/(aspect_max-aspect_mid))*(aspect-aspect_max);
else
    grade=grade_max;
end


end
