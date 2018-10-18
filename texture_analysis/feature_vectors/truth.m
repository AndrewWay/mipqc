function [ frac ] = truth( RGB,thres)
%TRUTH Summary of this function goes here
%   Detailed explanation goes here
    if(size(RGB,3)>1)
        BW=im2bw(RGB,thres);
    else
        BW=RGB;
    end
    
    BW=logical(BW);
    BWsize1=size(BW,1);
    BWsize2=size(BW,2);
    
    cumsum=0;
    for i=1:BWsize1
        for j=1:BWsize2
            if(BW(i,j))
                cumsum=cumsum+1;
            end
        end
    end
    
    frac=cumsum/(BWsize1*BWsize2);
end

