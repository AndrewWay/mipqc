function [ BMU_i,BMU_j,err] = findBMU( vec,som )
%FINDBMU Summary of this function goes here
%   Detailed explanation goes here
som_dim2=size(som,2);
som_dim3=size(som,3);

BMU_i=0;
BMU_j=0;
dist=inf;
% Determine which nodes' vector is most like input vector.
for i=1:som_dim2
    for j=1:som_dim3
        tmp = norm(som(:,i,j)-vec,2);
        if(tmp<dist)
            dist=tmp;
            BMU_i=i;
            BMU_j=j;
        end
    end
end
err=dist;

end

