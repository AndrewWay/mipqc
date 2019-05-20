function [error_image] = create_mip_error_image(I,SOM,nFeatures,zmu,zsigma,tCoeff)
%CREATE_MIP_ERROR_IMAGE Creates grayscale image based on error from
%classifying image subsections to best matching unit in som


number_of_image_divs1 = 100;
number_of_image_divs2 = 100;

fprintf("Creating uData...\n");

new_cells = dice(I,number_of_image_divs1,number_of_image_divs2);

%Find BMU

distances=zeros(number_of_image_divs1,number_of_image_divs2);
y1=1;
for i=1:number_of_image_divs1
    x1=1;
    for j=1:number_of_image_divs2
        img_ij=cell2mat(new_cells(i,j));
        
        dim1_ij=size(img_ij,1);
        dim2_ij=size(img_ij,2);
        
        
        featVec = create_feature_vector(img_ij,nFeatures);
        %MUST ZSCORE THIS DATA TO MATCH ZDATA (refer to loadData.m)
        featVec=(featVec-zmu)./zsigma;
        featVec = featVec*tCoeff;
        
        bmu_distance=BMU_error(net,featVec);
        
        distances(i,j)=bmu_distance;
        
        x1=x1+dim2_ij;
    end
    y1=y1+dim1_ij;
end

distances=floor(255*(1-distances/max(distances(:))));
error_image = zeros(size(I,1),size(I,2));
y1=1;
for i=1:number_of_image_divs1
    x1=1;
    for j=1:number_of_image_divs2
        img_ij=cell2mat(new_cells(i,j));
        
        dim1_ij=size(img_ij,1);
        dim2_ij=size(img_ij,2);
        
        
        error_image(y1:y1+dim1_ij-1,x1:x1+dim2_ij-1)=distances(i,j);
        
        x1=x1+dim2_ij;
    end
    y1=y1+dim1_ij;
end

end

