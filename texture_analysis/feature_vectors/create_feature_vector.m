function [ feature_vector ] = create_feature_vector(mat,nFeatures)
%CREATE_FEATURE_VECTOR Creates a single column feature vector
thres=0.6;

feature_vector=zeros(1,nFeatures);

if(size(mat,3)>1)
    gmat=rgb2gray(mat);
else
    gmat=mat;
end
glcm = graycomatrix(gmat, 'offset', [0 1], 'Symmetric', true);
x=haralick_features(glcm);

feature_vector(1,1)=mean_gray_level(gmat);
feature_vector(1,2)=median_gray_level(gmat);
feature_vector(1,3)=x(1);
feature_vector(1,4)=x(2);
%feature_vector(1,5)=x(3); results in nan
feature_vector(1,5)=x(4);
feature_vector(1,6)=x(5);
feature_vector(1,7)=x(6);
feature_vector(1,8)=x(7);
feature_vector(1,9)=x(8);
feature_vector(1,10)=x(9);
feature_vector(1,11)=x(10);
feature_vector(1,12)=x(11);
%feature_vector(1,14)=x(12);
feature_vector(1,13)=x(13);
feature_vector(1,14)=x(14);
feature_vector(1,15)=blob(mat,0.5);
feature_vector(1,16)=blob(mat,0.6);
feature_vector(1,17)=blob(mat,0.7);
feature_vector(1,18)=blob(mat,0.8);
feature_vector(1,19)=blob(mat,0.9);
feature_vector(1,20)=calc_ttd(mat);

if(nFeatures<20)
   fprintf("WARNING: Number of features less than feature vector size\n"); 
end

end

