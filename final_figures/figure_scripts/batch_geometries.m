%SURFACE AREA HISTOGRAM
hist(geometries(:,2),100);

title('Surface areas of 150 MIP films');
xlabel('Surface Area (mm^2)');
saveas(gcf,'surface_area.png');

%ASPECT RATIO HISTOGRAM
hist(geometries(:,3),100);

title('Aspect Ratios of 150 MIP films');
xlabel('Aspect Ratio');
saveas(gcf,'aspect_ratio.png');

%AVERAGE INTERNAL ANGLE HISTOGRAM
hist(geometries(:,4),100);

title('Average Internal Angles of 150 MIP films');
xlabel('Average Internal Angle (Degrees)');
saveas(gcf,'internal_angle.png');

%STANDARD DEVIATION OF INTERNAL ANGLE HISTOGRAM
hist(geometries(:,5),100);

title('Standard Deviation of Internal Angles of 150 MIP films');
xlabel('Standard Deviation (Angles)');
saveas(gcf,'std.png');

%EDGE ROUGHNESS HISTOGRAM
hist(geometries(:,6),100);

title('Edge Roughness of 150 MIP films');
xlabel('Fraction of Edge Considered Too Rough');
saveas(gcf,'edge_roughness.png');

%EDGE WEAKNESS HISTOGRAM
hist(geometries(:,7),100);

title('Edge Weakness of 150 MIP films');
xlabel('Fraction of Edge considered too weak');
saveas(gcf,'edge_weakness.png');