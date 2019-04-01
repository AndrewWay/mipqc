clear all;
close all;
pngFileName = strcat('data/B/MIP5.jpg');
if exist(pngFileName, 'file')
    
    %Read MIP image to matrix
    I = imread(pngFileName);
    
    %
    %         figure(1), imshow(I);
    %         pause;
    %         close(figure(1));
    %
    
    % Find and return the MIP.
    [MIP]=extract_mip(I);
    
    %MIP=I;
    figure(1),imshow(MIP);
    pause;
    %close(figure(1));
    %Use the following line if you don't want tom  extract
    %MIP=I;
    Itmp=MIP(703:919,1177:1416);
    blobp5=im2bw(Itmp,0.5);
    blobp9=im2bw(Itmp,0.8);
    figure(2),imshow(blobp5);
    figure(3),imshow(blobp9);

else
    fprintf('File %s does not exist.\n', pngFileName);
end