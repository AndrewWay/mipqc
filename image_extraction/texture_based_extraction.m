%Determines what cells are "mip-like"




close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    
    %     %Read into MIP image to matrices
    I = imread(pngFileName);
    %
    %     % Find and return the MIP.
    %     %[MIP]=extract_mip(I);
    MIP=I;
    figure(1),imshow(MIP);
    
    pause;
    close all;
    %Use the following line if you don't want to extract
    
   %TODO craete mip imge
    
contour(distances);
pause;
    
contour_based_extraction_subscript    
%texture_extraction_subscript
    
else
    fprintf("File does not exist.\n");
end