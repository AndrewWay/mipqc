%Run the following before running this script:

close all;

ttd_image=MIP;
imageDim1=size(ttd_image,1);
imageDim2=size(ttd_image,2);

mip_cells=dice(MIP,img_dim1Divisions,img_dim2Divisions);
ttd_cutoff=1.47;
max_ttd=max(ttd_values(:));
high_ttd_color=[1,0,0];
low_ttd_color=[0,0,0];
figure(1),imshow(ttd_image);
hold on;

x1=1;
y1=1;
for ii=1:img_dim1Divisions
    img_pixel_j=1;
    x1=1;
    for jj=1:img_dim2Divisions
        img_ij=cell2mat(mip_cells(ii,jj));
        ttd=calc_ttd(img_ij);
        dim1_ij=size(img_ij,1);
        dim2_ij=size(img_ij,2);
        %fprintf("TTD(%d,%d): %f\n",ii,jj,ttd); 
  %      figure(2),imshow(cell2mat(cell_ij));
        %Map the TTD to a color
        ttd_color_fact=(ttd-ttd_cutoff)/max_ttd;
        if(ttd_color_fact<0)
            ttd_color_fact=0;
        elseif(ttd_color_fact>1)
            ttd_color_fact=1;
        end
        ttd_color=ttd_color_fact*high_ttd_color;
        if(ttd_color_fact>0)
        rectangle('Position',[x1,y1,dim2_ij,dim1_ij],...
            'Curvature',[0,0],...
            'EdgeColor', ttd_color,...
            'LineWidth', 1,...
            'LineStyle','-')
        end
        x1=x1+dim2_ij;
    end
    y1=y1+dim1_ij;
end