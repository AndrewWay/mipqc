numOfImages=size(image_cells,1);

ttd_values=zeros(numOfImages,1);

for i=1:numOfImages
    %get the ith cell
    img_cell=image_cells(i,1);
    img=cell2mat(img_cell);
    %Calculate the TTD for this cell
    [ttd]=calc_ttd(img);
    %Store the result
    ttd_values(i,1)=ttd;
end