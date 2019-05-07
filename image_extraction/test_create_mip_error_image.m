close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    %Read into MIP image to matrices
    I = imread(pngFileName);
    
    figure(1),imshow(I);
    
    pause;
    
    error_image = create_mip_error_image(I,net,nFeatures,zmu,zsigma,tCoeff);
    figure(2),imshow(uint8(error_image));
else
    fprintf("File does not exist.\n");
end