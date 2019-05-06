function [candidates] = find_candidate_rectangles(lines1,lines2)
%FIND_CANDIDATE_RECTANGLES Summary of this function goes here
%   Detailed explanation goes here

nLines1=size(lines1,2);
nLines2=size(lines2,2);
%grade lines
candidates = [];

for i=1:nLines1
    linei=lines1(:,i);
    for j=i+1:nLines1
        linej=lines1(:,j);
        for k=1:nLines2
            linek=lines2(:,k);
            for l=k+1:nLines2
                linel=lines2(:,l);
                
                [tmp_fit_grade]=grade_rectangle([linei,linej],[linel,linek]);
                candidates=[candidates;i,j,k,l,tmp_fit_grade];

                
            end
        end
    end
end

end

