close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');

if exist(pngFileName, 'file')
    I=imread(pngFileName);
    
    %I=I(500:2684,1700:end,:);
    
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);
    
    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2,1);
    
else
    fprintf("File does not exist.\n");
end