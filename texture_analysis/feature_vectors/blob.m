function [ blobFraction ] = blob( RGB ,thres)
%BLOB Given an RGB matrix, returns the relative size of the 
%largest contiguous area of an intensity matrix with elements equal to 1
    if(size(RGB,3)>1)
        BW=im2bw(RGB,thres);
    else
        BW=RGB;
    end
    %imshow(BW);
    P=regionprops(logical(BW),'area');
    blobSize=max([P.Area]);
    if(isempty(P))
        blobFraction=0;
    else
        blobFraction=blobSize/(size(BW,1)*size(BW,2));
    end
    %TODO is it okay to normalize blobSize by number of pixels in RGB?
    %If RGB size is not constant, then we are introducing inconsistency.n 
end

