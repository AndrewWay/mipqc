
if exist('mip','var')==0
    I=imread('B5.jpg');
    mip=extract_mip(I);
%    imshow(mip);
end

img_dim1Divisions=50;
img_dim2Divisions=100;

regionCells = dice(mip,img_dim1Divisions,img_dim2Divisions);
means=zeros(img_dim1Divisions,img_dim2Divisions);
medians=zeros(img_dim1Divisions,img_dim2Divisions);
stds=zeros(img_dim1Divisions,img_dim2Divisions);
skewnesses=zeros(img_dim1Divisions,img_dim2Divisions);
kurtoses=zeros(img_dim1Divisions,img_dim2Divisions);

for i=1:img_dim1Divisions
    for j=1:img_dim2Divisions
        rgbmat=cell2mat(regionCells(i,j));
        means(i,j)=mean_gray_level(rgbmat);
        medians(i,j)=median_gray_level(rgbmat);
        
    end
end

histogram(medians)

