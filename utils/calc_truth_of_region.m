function [ truth ] = calc_truth_of_region( xInts,yInts,I_bw )
%CALC_TRUTH_OF_REGION Summary of this function goes here
%   Detailed explanation goes here
pixel_step=1;
k = convhull(xInts(:),yInts(:));
xInts=xInts(:);
xv=xInts(k);
yInts=yInts(:);
yv=yInts(k);
truth=0;
area=0;
%i_start=floor(min(xv(:)));
%i_end=ceil(max(xv(:)));
%j_start=floor(min(yv(:)));
%j_end=ceil(max(yv(:)));

inPoints = round(polygrid(xv, yv, 1));

for i=1:size(inPoints,1)
    x=inPoints(i,1);
    y=inPoints(i,2);
    if(I_bw(y,x)==1)
        truth=truth+1;
    end
    area=area+1;
end
%
%
% if(i_end>size(I_bw,2))
%    i_end=size(I_bw,2);
% end
%
% if(i_start<1)
%    i_start=1;
% end
%
% if(j_end>size(I_bw,1))
%    j_end=size(I_bw,1);
% end
%
% if(j_start<1)
%    j_start=1;
% end
%
%
% for i=i_start:pixel_step:i_end
%     for j=j_start:pixel_step:j_end
%         if(inpolygon(i,j,xv,yv))
%             if(I_bw(j,i)==1)
%                 truth=truth+1;
%             end
%             area=area+1;
%         end
%     end
% end
truth=truth/area;
end

