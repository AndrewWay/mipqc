function [ featVecs ] = createFeatVecs( rgbMat,nFeats,img_dim1Divisions,img_dim2Divisions)
%CREATEFEATVECS Summary of this function goes here
%   Detailed explanation goes here

thres=0.6;
centiles=[0.5,90];

featVecs=zeros(nFeats,img_dim1Divisions,img_dim2Divisions);
    
regionCells = dice(rgbMat,img_dim1Divisions,img_dim2Divisions);

for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        rgbmat=cell2mat(regionCells(i,j));
        %TODO implement haralick features
        %https://www.hindawi.com/journals/ijbi/2015/267807/
        %grayCents = createGrayCentileVec(rgbmat,centiles);
        
        [rCents,bCents,gCents]= createCentileVec(rgbmat,centiles);
        
        gI=rgb2gray(rgbmat);
        
        gray_centiles = gray_level_centiles(gI,centiles);
        
        glcm=graycomatrix(gI);
        
        stats = graycoprops(glcm);
        contrast=stats.Contrast/(size(glcm,1)-1)^2;
        %correlation=(stats.Correlation+1)/2;
        energy=stats.Energy;
        homogeneity=stats.Homogeneity;
        
        %Blob feature vector component
        f_blob=blob(rgbmat,thres);
        
        %Truth feature vector component
        f_truth=truth(rgbmat,thres);
        
        %connectiveness feature vector component
           %f_dif=connectiveness(f_blob,f_truth);
        
        featVecs(:,i,j) = [
        %rCents/255;
        bCents/255;
        %gCents/255;
        gray_centiles/255;
        %f_truth; 
        contrast;
        energy;
        %homogeneity;
        ];
    end
end

end

