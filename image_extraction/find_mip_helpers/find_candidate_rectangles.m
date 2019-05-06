function [candidates] = find_candidate_rectangles(lines11,lines22,scale_factor)
%FIND_CANDIDATE_RECTANGLES Summary of this function goes here
%   Detailed explanation goes here

nLines1=size(lines11,2);
nLines2=size(lines22,2);
%grade lines
candidates = [];

for i=1:nLines1
    linei=lines11(:,i);
    for j=i+1:nLines1
        linej=lines11(:,j);
        for k=1:nLines2
            linek=lines22(:,k);
            for l=k+1:nLines2
                linel=lines22(:,l);
                
                [tmp_fit_grade]=grade_rectangle([linei,linej],[linel,linek],scale_factor);
                candidates=[candidates;i,j,k,l,tmp_fit_grade];

                
            end
        end
    end
end

end

