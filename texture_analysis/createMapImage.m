function [im] = createMapImage( rgbCells, mappingIndices,classifier)
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
                k_index = k+px_shift1;
                l_index = l+px_shift2;
                
                im(k_index,l_index,1)=rgbMat(k,l,1);
                im(k_index,l_index,2)=rgbMat(k,l,2);
                im(k_index,l_index,3)=rgbMat(k,l,3);
                %Add additional highlighting if classifier matrix defined
                if(exist('classifier','var'))
                    classLabel = classifier(mapIndex1,mapIndex2);
                    color = classLabelToColor(classLabel);
                    if(k==1||l==1)
                        im(k_index,l_index,1)=color(1);
                        im(k_index,l_index,2)=color(2);
                        im(k_index,l_index,3)=color(3);
                    elseif(k==rgbMatSize1||l==rgbMatSize2)
                        im(k_index,l_index,1)=color(1);
                        im(k_index,l_index,2)=color(2);
                        im(k_index,l_index,3)=color(3);
                    end
                end
            end
        end
        pxsOcc(mapIndex1,mapIndex2)=1;
    end
end
im=uint8(im);
imshow(im)
end

