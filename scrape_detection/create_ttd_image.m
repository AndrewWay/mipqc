ttd_image=MIP;

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
        
        
        
        img_pixel_j=img_pixel_j+img_cell_dim2;
        img_cell_dim1=size(img_cell,1);
        img_cell_dim2=size(img_cell,2);
        for k=img_pixel_i:img_pixel_i+img_cell_dim1
            for l=img_pixel_j:img_pixel_j+img_cell_dim2
                ttd_image(k,l,1)=ttd_color(1,1);
                ttd_image(k,l,2)=ttd_color(1,2);
                ttd_image(k,l,3)=ttd_color(1,3);
                
            end
        end
        img_pixel_i=img_pixel_i+img_cell_dim1;
    end
end

figure(1), imshow(ttd_image)
figure(2), imshow(MIP)