clear all;
close all;

numOfImages=11;

threses=[0.5,0.55,0.6,0.65,0.7,0.75];
nThres=size(threses,2);
hold on;
for i=1:nThres
    areas=[];
    for k=1:numOfImages
        pngFileName = strcat(...
            '../Surface Defect Detection/defectdetect/MIPs/MIP'...
            , num2str(k), '.jpg');
        if exist(pngFileName, 'file')
            I=imread(pngFileName);
            mip=extract_mip(I);
    
            BW1=im2bw(mip,threses(i));
            
            areas1=regionprops(BW1, 'Area');
            areas1=cat(1,areas1.Area);
            areas=[areas; areas1];
        else
            fprintf('File %s does not exist.\n', pngFileName);
        end
    end
    subplot(nThres,1,i);
    hist(areas,3000), xlim([0 3000]);
    
end
hold off;