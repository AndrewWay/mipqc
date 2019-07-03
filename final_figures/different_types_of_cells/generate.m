good_index=31094;
light_bubbles_index=53082;
chaotic_speckles_index=10902;
clumps_index=59967;
edge_scratch_index=47521;
strong_bubbles_index=35286;
glass_slide_index=28373;
specks_index=54253;



A_index=good_index;
B_index=clumps_index;
C_index=chaotic_speckles_index;
D_index=specks_index;
E_index=light_bubbles_index;
F_index=strong_bubbles_index;
G_index=edge_scratch_index;
H_index=glass_slide_index;

imwrite(cell2mat(image_cells(A_index)),'A.jpg')
imwrite(cell2mat(image_cells(B_index)),'B.jpg')
imwrite(cell2mat(image_cells(C_index)),'C.jpg')
imwrite(cell2mat(image_cells(D_index)),'D.jpg')
imwrite(cell2mat(image_cells(E_index)),'E.jpg')
imwrite(cell2mat(image_cells(F_index)),'F.jpg')
imwrite(cell2mat(image_cells(G_index)),'G.jpg')
imwrite(cell2mat(image_cells(H_index)),'H.jpg')

fprintf('Cell & PC1 Score & PC2 Score & PC3 Score & PC4 Score\\\\ \n');
fprintf('A & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(A_index,:));
fprintf('B & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(B_index,:));
fprintf('C & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(C_index,:));
fprintf('D & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(D_index,:));
fprintf('E & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(E_index,:));
fprintf('F & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(F_index,:));
fprintf('G & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(G_index,:));
fprintf('H & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',tData(H_index,:));


feature_names=["Mean Gray Level", "Median Gray Level","Energy","Contrast","Variance",...
    "Homogeneity","Sum Average","Sum Variance", "Sum Entropy", "Entropy",...
    "Difference Variance","Difference Entropy","IMC2","Maximal Correlation Coeff.",...
    "Blob0.5","Blob0.6","Blob0.7","Blob0.8","Blob0.9","TTD"];
fprintf('Feature & PC1 Weight & PC2 Weight & PC3 Weight & PC4 Weight\\\\ \n');
for i=1:nFeatures
    fprintf('%s & %0.2f & %0.2f & %0.2f & %0.2f\\\\ \n',feature_names(1,i),tCoeff(i,:));
end



