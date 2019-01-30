% clear all
% close all
% 
% %Load the image
% I0 = imread('../Surface Defect Detection/defectdetect/MIPs/MIP5.jpg');
% 
% MIP=extract_mip(I0);
% 
% img_dim1Divisions=40;
% img_dim2Divisions=40;

regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
regionCells_dim1=size(regionCells,1);
regionCells_dim2=size(regionCells,1);

img_pixel_i=1;
img_pixel_j=1;
ttd_values=zeros(img_dim1Divisions,img_dim2Divisions);

for ii=1:regionCells_dim1
    for jj=1:regionCells_dim2
        %Get the (i,j)th cell
        cell=regionCells(ii,jj);
        img_cell=cell2mat(cell);
        %imshow(img_cell);
        %Calculate the TTD for this cell
        [ttd]=calc_ttd(img_cell);
        %Store the result
        ttd_values(ii,jj)=ttd;
        fprintf("TTD(%d,%d): %f\n",ii,jj,ttd); 
        %pause;
    end
end
