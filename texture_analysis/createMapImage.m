function [im] = createMapImage( rgbCells, mappingIndices)
%CREATEMAPIMAGE Summary of this function goes here
%   Detailed explanation goes here

som_size1=max(mappingIndices(:,1));
som_size2=max(mappingIndices(:,2));


nCells = size(rgbCells,1);


%Find the largest dimensions of all cells
[s,d] = cellfun(@size,rgbCells);
out = mean([s,d]);

%find maximum cell dimensions
regionPxsize1=floor(out(1,1));
regionPxsize2=69;%floor(out(1,2));

im =  zeros(som_size1*regionPxsize1,som_size2*regionPxsize2,3);

pxsOcc=zeros(som_size1,som_size2);

for i=1:nCells
    mapIndex1 = mappingIndices(i,1);
    mapIndex2 = mappingIndices(i,2);
    if(pxsOcc(mapIndex1,mapIndex2)==0)
        region = rgbCells(i);
        rgbMat = cell2mat(region);
        
        rgbMatSize1=size(rgbMat,1);
        rgbMatSize2=size(rgbMat,2);
        
        px_shift1=regionPxsize1*(mapIndex1-1);
        px_shift2=regionPxsize2*(mapIndex2-1);
        
        for k=1:rgbMatSize1
            for l=1:rgbMatSize2
                im(k+px_shift1,l+px_shift2,1)=rgbMat(k,l,1);
                im(k+px_shift1,l+px_shift2,2)=rgbMat(k,l,2);
                im(k+px_shift1,l+px_shift2,3)=rgbMat(k,l,3);
                
            end
        end
        pxsOcc(mapIndex1,mapIndex2)=1;
    end
end
im=uint8(im);
imshow(im)
end

