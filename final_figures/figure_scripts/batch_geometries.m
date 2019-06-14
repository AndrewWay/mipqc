processed_geometries=[];

%Filter out MIP films which were clearly mis-processed
for i=1:size(geometries)
    mip_index=geometries(i,1);
    aspect_ratio=geometries(i,3);
    surface_area=geometries(i,2);
    if(aspect_ratio>3)
        fprintf("MIP%d has an abnormally high aspect ratio\n",mip_index);
    elseif(surface_area>280)
        fprintf("MIP %d has an abnormally large surface area\n",mip_index);
    elseif(surface_area<100)
        fprintf("MIP %d has an abnormally low surface area\n",mip_index);
    else
        processed_geometries=[processed_geometries;geometries(i,:)];
    end
end

%SURFACE AREA HISTOGRAM
hist(processed_geometries(:,2),30);

title('Surface areas of 137 MIP films');
xlabel('Surface Area (mm^2)');
saveas(gcf,'surface_area.png');

%ASPECT RATIO HISTOGRAM
hist(processed_geometries(:,3),30);

title('Aspect Ratios of 137 MIP films');
xlabel('Aspect Ratio');
saveas(gcf,'aspect_ratio.png');

%AVERAGE INTERNAL ANGLE HISTOGRAM
hist(processed_geometries(:,4),20);

title('Average Internal Angles of 137 MIP films');
xlabel('Average Internal Angle (Degrees)');
saveas(gcf,'internal_angle.png');

%STANDARD DEVIATION OF INTERNAL ANGLE HISTOGRAM
hist(processed_geometries(:,5),20);

title('Standard Deviation of Internal Angles of 137 MIP films');
xlabel('Standard Deviation (Angles)');
saveas(gcf,'std.png');

%EDGE ROUGHNESS HISTOGRAM
hist(processed_geometries(:,6),20);

title('Edge Roughness of 137 MIP films');
xlabel('Fraction of Edge Considered Too Rough');
saveas(gcf,'edge_roughness.png');

%EDGE WEAKNESS HISTOGRAM
hist(processed_geometries(:,7),20);

title('Edge Weakness of 137 MIP films');
xlabel('Fraction of Edge considered too weak');
saveas(gcf,'edge_weakness.png');