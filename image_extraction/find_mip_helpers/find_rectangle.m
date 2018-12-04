function [lines11, lines22] = find_rectangle(lines1,lines2)
nLines1=size(lines1,2);
nLines2=size(lines2,2);
%fprintf("NOTE: The expected lengths for MIPs are being set in find_rectangle\n");
%length1_max;
%length2_max;

%
ang_tol=5;
r_min=50;

%Indices for optimal lines
iOpt=0;
jOpt=0;
kOpt=0;
lOpt=0;
fit_err=inf;
fit_grade=0;

for i=1:nLines1
    linei=lines1(:,i);
    ti=lines1(1,i);
    ri=lines1(2,i);
    for j=i+1:nLines1
        linej=lines1(:,j);
        tj=lines1(1,j);
        rj=lines1(2,j);
        for k=1:nLines2
            linek=lines2(:,k);
            tk=lines2(1,k);
            rk=lines2(2,k);
            for l=k+1:nLines2
                linel=lines2(:,l);
                tl=lines2(1,l);
                rl=lines2(2,l);
                [si,sj,sk,sl]=calc_sides_lengths(linei,linej,linek,linel);
                %si_grade = 
                %fprintf("Indices: %f %f %f %f\n",i,j,k,l);
                [angle_grade]=grade_angles(ti,tj,tk,tl);
                [aspect_grade]=grade_aspect(si,sj,sk,sl);
                tmp_fit_grade=2*angle_grade+aspect_grade;
                
                if(tmp_fit_grade>fit_grade)
                    fit_grade=tmp_fit_grade;
                    iOpt=i;
                    jOpt=j;
                    kOpt=k;
                    lOpt=l;
                end
                
            end
        end
    end
end
    fprintf("Optimal indices: %f %f %f %f\n",iOpt,jOpt,kOpt,lOpt);
%     %Create optimal set of lines
lines11=[lines1(:,iOpt) lines1(:,jOpt)];
lines22=[lines2(:,kOpt) lines2(:,lOpt)];

[siOpt,sjOpt,skOpt,slOpt]=calc_sides_lengths(lines1(:,iOpt),lines1(:,jOpt),lines2(:,kOpt),lines2(:,lOpt));
%     fprintf("Optimal rectangle side lengths: %f %f %f %f\n",siOpt,sjOpt,skOpt,slOpt);
end