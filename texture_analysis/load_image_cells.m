
close all;
clear all;

%PARAMETERS
startIndex=6858;
stopIndex=6908;%7008;
nImages = stopIndex-startIndex;

img_dim1Divisions=40;
img_dim2Divisions=40;


%each row in data corresponds to the same row in imageCells. 
nObservations=nImages*img_dim1Divisions*img_dim2Divisions;
image_cells = [];%cell(nObservations,1);%column vector containing cells of images

%Load images into memory
cellIndex=1;

for k=startIndex:stopIndex
    pngFileName=strcat('data/D/D', num2str(k), '.png');
    if exist(pngFileName, 'file')
        fprintf("Processing MIP D%d\n",k);
        %Read MIP image to matrix
        MIP = imread(pngFileName);
    
        regionCells = dice(MIP,img_dim1Divisions,img_dim2Divisions);
        regionCells_dim1=size(regionCells,1);
        regionCells_dim2=size(regionCells,1);

        %close(figure(1));
        %Use the following line if you don't want tom  extract
        %MIP=I;
        
        for ii=1:regionCells_dim1
            for jj=1:regionCells_dim2
                cell_ij=regionCells(ii,jj);
                mat=cell2mat(cell_ij);
                image_cells=[image_cells;cell_ij];
                cellIndex=cellIndex+1;
            end
        end
    else
        fprintf('File %s does not exist.\n', pngFileName);
    end
end

save('training_image_cells.mat','image_cells');