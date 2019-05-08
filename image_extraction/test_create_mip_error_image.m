close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');
number_of_image_divs1=60;
number_of_image_divs2=60;


if exist(pngFileName, 'file')
    %Read into MIP image to matrices
    I = imread(pngFileName);
    
    figure(1),imshow(I);
    
    pause;
    new_cells = dice(I,number_of_image_divs1,number_of_image_divs2);

    error_matrix = create_error_matrix(new_cells,net,nFeatures,zmu,zsigma,tCoeff);
    %error_image = create_mip_error_image(I,net,nFeatures,zmu,zsigma,tCoeff);
    %figure(2),imshow(uint8(error_image));
    contourf(error_matrix);
else
    fprintf("File does not exist.\n");
end