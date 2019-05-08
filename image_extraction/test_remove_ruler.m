close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    I = imread(pngFileName);

    figure(1),imshow(I);
    pause;
    
    figure(2),imshow(remove_ruler(I))
else
    fprintf("File does not exist.\n");
end