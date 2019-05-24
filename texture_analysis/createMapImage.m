function [im] = createMapImage( rgbCells, mappingIndices,classifier)
%CREATEMAPIMAGE Summary of this function goes here
%   Detailed explanation goes here
line_width=3;
class_box_margin=5;
som_size1=max(mappingIndices(:,1));
som_size2=max(mappingIndices(:,2));


nCells = size(rgbCells,1);


%Find the largest dimensions of all cells
[s,d] = cellfun(@size,rgbCells);
out = mean([s,d]);

%find maximum cell dimensions
%TODO Fix this.
regionPxsize1=floor(out(1,1));
regionPxsize2=floor(0.35*out(1,2));

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
                
            end
        end
        %Add additional highlighting if classifier matrix defined
        if(exist('classifier','var'))
            classLabel = classifier(mapIndex1,mapIndex2);
            if(classLabel>0)
                color = classLabelToColor(classLabel);
                
                k_start = class_box_margin+px_shift1;
                k_end = px_shift1+rgbMatSize1-class_box_margin;
                l_start = class_box_margin+px_shift2;
                l_end=px_shift2+rgbMatSize2-class_box_margin;
                
                %Highlight left side of box
                im(k_start:k_end,l_start:l_start+line_width,1)=color(1);
                im(k_start:k_end,l_start:l_start+line_width,2)=color(2);
                im(k_start:k_end,l_start:l_start+line_width,3)=color(3);
                
                %Highlight right side of box
                im(k_start:k_end,l_end-line_width:l_end,1)=color(1);
                im(k_start:k_end,l_end-line_width:l_end,2)=color(2);
                im(k_start:k_end,l_end-line_width:l_end,3)=color(3);
                
                %Highlight top side of box
                im(k_start:k_start+line_width,l_start:l_end,1)=color(1);
                im(k_start:k_start+line_width,l_start:l_end,2)=color(2);
                im(k_start:k_start+line_width,l_start:l_end,3)=color(3);
                
                %Highlight bottom side of box
                im(k_end-line_width:k_end,l_start:l_end,1)=color(1);
                im(k_end-line_width:k_end,l_start:l_end,2)=color(2);
                im(k_end-line_width:k_end,l_start:l_end,3)=color(3);
                
            end
            
        end
        
        pxsOcc(mapIndex1,mapIndex2)=1;
    end
end
im=uint8(im);
end

