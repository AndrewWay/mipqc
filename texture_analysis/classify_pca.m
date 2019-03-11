nCells = size(image_cells,1);

nPics=8;

for i=1:20
    
    scores = zdata*coeff(:,i);
    [B,I] = sort(scores,'ascend');
    
    suptitle(['Worst',num2str(nPics),' scoring cells for PC',num2str(i)]);
    
    j=1;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=2;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=3;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=4;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=5;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=6;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=7;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=8;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,j),imshow(cell_img);
    
    j=nCells;
    img_index = I(j);
    cell_img = cell2mat(image_cells(img_index,1));
    subplot(3,3,9),imshow(cell_img);
    title("Best scoring cell");
    
    
    pause;
    close all;
end