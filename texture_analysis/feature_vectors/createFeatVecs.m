function [ data ] = createFeatVecs( rgbMat,nFeats,img_dim1Divisions,img_dim2Divisions)
%CREATEFEATVECS Summary of this function goes here
%   Detailed explanation goes here

thres=0.6;
centiles=[0.5,90];


regionCells = dice(rgbMat,img_dim1Divisions,img_dim2Divisions);

%connectiveness feature vector component
%f_dif=connectiveness(f_blob,f_truth);
data=zeros(img_dim1Divisions*img_dim2Divisions,nFeats);
data_index=1;

for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        
        %
        rgbmat=cell2mat(regionCells(i,j));
        gmat=rgb2gray(rgbmat);
        glcm = graycomatrix(gmat, 'offset', [0 1], 'Symmetric', true);
        %             means(i,j)=mean_gray_level(rgbmat);
        %             medians(i,j)=median_gray_level(rgbmat);
        x=haralick_features(glcm);
        %             asms(i,j)=x(1);
        %             contrasts(i,j)=x(2);
        %             correlations(i,j)=x(3);
        %             vars(i,j)=x(4);
        %             ivds(i,j)=x(5);
        %             sumavgs(i,j)=x(6);
        %             sumvars(i,j)=x(7);
        %             suments(i,j)=x(8);
        %             ents(i,j)=x(9);
        %             diffvars(i,j)=x(10);
        %             diffents(i,j)=x(11);
        %             imc1s(i,j)=x(12);
        %             imc2s(i,j)=x(13);
        %             mccs(i,j)=x(14);
        
        data(data_index,1)=mean_gray_level(rgbmat);
        data(data_index,2)=median_gray_level(rgbmat);
        data(data_index,3)=x(1);
        data(data_index,4)=x(2);
        %data(data_index,5)=x(3);
        data(data_index,5)=x(4);
        data(data_index,6)=x(5);
        data(data_index,7)=x(6);
        data(data_index,8)=x(7);
        data(data_index,9)=x(8);
        data(data_index,10)=x(9);
        data(data_index,11)=x(10);
        data(data_index,12)=x(11);
        %data(data_index,14)=x(12);
        data(data_index,13)=x(13);
        data(data_index,14)=x(14);
        data(data_index,15)=blob(rgbmat,thres);
        
        data_index=data_index+1;
        
        
        %   featVecs(:,i,j) = % [
        %         %rCents/255;
        %         bCents/255;
        %         %gCents/255;
        %         gray_centiles/255;
        %         %f_truth;
        %         contrast;
        %         energy;
        %         %homogeneity;
        %         ];
    end
end

end

