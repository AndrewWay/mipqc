
%Calculate truth of cell at threshold=0.75
%If truth greater than 0.1, flag

close all;
img_dim1Divisions=40;
img_dim2Divisions=40;
regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);

imshow(MIP);
hold on;

x1=1;
y1=1;
for ii=1:img_dim1Divisions
    x1=1;
    for jj=1:img_dim2Divisions
        img_ij=cell2mat(regionCells(ii,jj));
        dim1_ij=size(img_ij,1);
        dim2_ij=size(img_ij,2);
        %fprintf("TTD(%d,%d): %f\n",ii,jj,ttd); 
  %      figure(2),imshow(cell2mat(cell_ij));

        if(truth(img_ij,0.75)>0.001)
        rectangle('Position',[x1,y1,dim2_ij,dim1_ij],...
            'Curvature',[0,0],...
            'EdgeColor', [1,0,0],...
            'LineWidth', 1,...
            'LineStyle','-')
        end
        x1=x1+dim2_ij;
    end
    y1=y1+dim1_ij;
end