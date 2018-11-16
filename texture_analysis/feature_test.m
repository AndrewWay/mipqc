
if exist('mip','var')==0
    I=imread('B5.jpg');
    mip=extract_mip(I);
    imshow(mip);
end

img_dim1Divisions=50;
img_dim2Divisions=100;

regionCells = dice(mip,img_dim1Divisions,img_dim2Divisions);
means=zeros(img_dim1Divisions,img_dim2Divisions);
medians=zeros(img_dim1Divisions,img_dim2Divisions);
stds=zeros(img_dim1Divisions,img_dim2Divisions);
skewnesses=zeros(img_dim1Divisions,img_dim2Divisions);
kurtoses=zeros(img_dim1Divisions,img_dim2Divisions);

%Calculate GLCM for Haralick features 
asms=zeros(img_dim1Divisions,img_dim2Divisions);
contrasts=zeros(img_dim1Divisions,img_dim2Divisions);
correlations=zeros(img_dim1Divisions,img_dim2Divisions);
vars=zeros(img_dim1Divisions,img_dim2Divisions);%sum of squares
ivds=zeros(img_dim1Divisions,img_dim2Divisions);
sumavgs=zeros(img_dim1Divisions,img_dim2Divisions);
sumvars=zeros(img_dim1Divisions,img_dim2Divisions);
suments=zeros(img_dim1Divisions,img_dim2Divisions);
ents=zeros(img_dim1Divisions,img_dim2Divisions);
diffvars=zeros(img_dim1Divisions,img_dim2Divisions);
diffents=zeros(img_dim1Divisions,img_dim2Divisions);
imc1s=zeros(img_dim1Divisions,img_dim2Divisions);
imc2s=zeros(img_dim1Divisions,img_dim2Divisions);
mccs=zeros(img_dim1Divisions,img_dim2Divisions); %max correlation coeff.

for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        rgbmat=cell2mat(regionCells(i,j));
        gmat=rgb2gray(rgbmat);
        glcm = graycomatrix(gmat, 'offset', [0 1], 'Symmetric', true);
        means(i,j)=mean_gray_level(rgbmat);
        medians(i,j)=median_gray_level(rgbmat);
        x=haralick_features(glcm);
        asms(i,j)=x(1);
        contrasts(i,j)=x(2);
        correlations(i,j)=x(3);
        vars(i,j)=x(4);
        ivds(i,j)=x(5);
        sumavgs(i,j)=x(6);
        sumvars(i,j)=x(7);
        suments(i,j)=x(8);
        ents(i,j)=x(9);
        diffvars(i,j)=x(10);
        diffents(i,j)=x(11);
        imc1s(i,j)=x(12);
        imc2s(i,j)=x(13);
        mccs(i,j)=x(14);
    end
end

histogram(medians)

