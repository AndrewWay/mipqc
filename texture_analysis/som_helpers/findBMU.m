function [ BMU_i,err] = findBMU( vec,som )
%FINDBMU Summary of this function goes here
%   Detailed explanation goes here
som_dim1=size(som,2);

BMU_i=0;
dist=inf;
% Determine which nodes' vector is most like input vector.
for i=1:som_dim1
        tmp = norm(som(i,:)-vec,2);
        if(tmp<dist)
            dist=tmp;
            BMU_i=i;
        end
    %end
end
err=dist;

end

