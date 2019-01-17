scatter(W(:,1),W(:,2));
hold on;
points=[-7.055,-0.3046;
        -2.01,-3.457;
        1.349,-5.682;
        -1.35,-2.39;
        -5.161,1.515;
        -1.086,-1.063;
        3.536,-3.302;
        -0.9625,1.955;
        -3.001,4.08;
        1.304,1.649;
        4.189,0.9105;
        9.741,3.262];
   
    imx_l=1;
npoints=size(points,1);
nData = size(W,1);
for i=1:nData
    p_i=W(i,:);
    %Display that cell on the point 
    cell_opt=image_cells(i,1);
    mat_opt=cell2mat(cell_opt);
    %imshow(mat_opt);
    %pause;
    %imagesc([.5 .5], [.6 .6], image(mat_opt))
    image(mat_opt,'XData', [p_i(1,1) p_i(1,1)+imx_l], 'YData', [p_i(1,2) p_i(1,2)-imx_l]);
    %image(image(mat_opt),'XData',[4 8],'YData',[-1/4 1/4])
    %image(flipud(imshow(mat_opt)), 'XData', p_i(1,1), 'YData', p_i(1,2));
end