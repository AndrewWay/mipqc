function [extract] = extract_rectangle(I,x1,y1,x2,y2)
    nRowPixels = floor(abs(y2-y1));
    nColPixels = floor(abs(x2-x1));
    extract = zeros(nRowPixels,nColPixels,3);
    for i=ceil(y1):floor(y2)
        for j=ceil(x1):floor(x2)
            extract(i-ceil(y1)+1,j-ceil(x1)+1,:)=I(i,j,:);
        end
    end
    extract = uint8(extract);
end
