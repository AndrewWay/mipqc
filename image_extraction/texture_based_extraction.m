%Determines what cells are "mip-like"


close all;
%pngFileName = strcat('data/D/D6943.png');
pngFileName = strcat('A:/MSC FINAL DATA/jpeg/D6888.jpg');
pngFileName= strcat('data/D_raw/_MG_6887.CR2');
   
if exist(pngFileName, 'file')
    
    %     %Read into MIP image to matrices
    I = imread(pngFileName);
    %
    %     % Find and return the MIP.
    %     %[MIP]=extract_mip(I);
    I=remove_ruler(I);
    figure(1),imshow(I);
  
    pause;
    close all;
    %Extraction process
    
    number_of_image_divs1=60;
    number_of_image_divs2=60;
    texture_error_weight=2;
    geometry_error_weight=2;
    
    
    
    new_cells = dice(I,number_of_image_divs1,number_of_image_divs2);
    
    error_matrix = create_error_matrix(new_cells,net,nFeatures,zmu,zsigma,tCoeff);
    total_texture_error=sum(error_matrix(:));
    %Retrieve the sets of lines enclosing the MIP in image I
    [lines1,lines2] = find_vertical_and_horizontal_lines(I);
    
    [candidate_rectangles] = find_candidate_rectangles(lines1,lines2);
    
    texture_extraction_subscript

else
    fprintf("File does not exist.\n");
end