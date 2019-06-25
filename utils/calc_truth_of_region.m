function [ truth ] = calc_truth_of_region( xInts,yInts,I_bw )
%CALC_TRUTH_OF_REGION Summary of this function goes here
%   Detailed explanation goes here
k = convhull(xInts(:),yInts(:));
xInts=xInts(:);
xv=xInts(k);
yInts=yInts(:);
yv=yInts(k);
truth=0;
area=0;
i_start=floor(min(xv(:)));
i_end=ceil(max(xv(:)));
j_start=floor(min(yv(:)));
j_end=ceil(max(yv(:)));
for i=i_start:i_end
    for j=j_start:j_end
        if(inpolygon(i,j,xv,yv))
            if(I_bw(i,j)==1)
                truth=truth+1;
            end
            area=area+1;
        end
    end
end
truth=truth/area;
end

