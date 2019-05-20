%Determines what cells are "mip-like"


close all;
%Good MIP: 6887;
%Bad MIP: 6894
%Ugly MIP: 6875
mip_index=6887;
output_identifier="good";
cr2FileName = strcat('data/D_raw/_MG_', num2str(mip_index), '.CR2');
    
pause_figure=1;

if exist(cr2FileName, 'file')
    %Read into MIP image to matrices
    I = imread(cr2FileName);
    I=remove_ruler(I);
    
    
    %ORIGINAL IMAGE
    figure(1),imshow(I);
    pause;
    
    %Find the four lines
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);

    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);

    %IMAGE WITH CHOSEN FOUR LINES BASED ON GEOMETRY
    candidate_rectangles=sortrows(candidate_rectangles,5);
    
    best_rectangle = candidate_rectangles(end,1:4);
    lines11=[lines1(:,best_rectangle(1)),lines1(:,best_rectangle(2))];
    lines22=[lines2(:,best_rectangle(3)),lines2(:,best_rectangle(4))];
    
    I_rectangle = draw_lines(lines11,lines22,I);
    figure(1),imshow(I_rectangle);
    pause;
    
    
    %IMAGE WITH GEOMETRIC PROPERTY OVERLAY
    
    
    
else
    fprintf("CR2 File does not exist.\n");
end