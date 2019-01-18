ttd_image=MIP;
imageDim1=size(ttd_image,1);
imageDim2=size(ttd_image,2);

min_ttd=0.20;
max_ttd=max(ttd_values(:));
high_ttd_color=[1,0,0];
low_ttd_color=[0,0,0];
imshow(ttd_image);
hold on;

for ii=1:regionCells_dim1
    img_pixel_j=1;
    for jj=1:regionCells_dim2
        ttd=ttd_values(ii,jj);
        
        %Map the TTD to a color
        ttd_color_fact=(ttd-min_ttd)/max_ttd;
        if(ttd_color_fact<0)
            ttd_color_fact=0;
        elseif(ttd_color_fact>1)
            ttd_color_fact=1;
        end
        ttd_color=ttd_color_fact*high_ttd_color;
        
        if(ttd_color_fact>0)
        [x1,x2,y1,y2] = sectionCorners(ii,jj,imageDim1/img_dim1Divisions,imageDim2/img_dim2Divisions);
        rectangle('Position',[x1,y1,x2-x1,y2-y1],...
            'Curvature',[0,0],...
            'EdgeColor', ttd_color,...
            'LineWidth', 1,...
            'LineStyle','-')
        end
    end
end